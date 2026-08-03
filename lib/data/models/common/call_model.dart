enum CallType { audio, video, unknown }

enum CallStatus { ringing, active, ended, unknown }

enum CallInviteStatus { pending, accepted, declined, unknown }

T _enumValue<T>(String? value, Map<String, T> values, T fallback) =>
    values[value] ?? fallback;

int _intValue(Object? value) =>
    value is int ? value : int.tryParse(value?.toString() ?? '') ?? 0;

DateTime? _dateValue(Object? value) =>
    value == null ? null : DateTime.tryParse(value.toString());

class CallUser {
  const CallUser({required this.id, required this.name, this.avatar});

  final int id;
  final String name;
  final String? avatar;

  factory CallUser.fromJson(Map<String, dynamic> json) => CallUser(
    id: _intValue(json['id']),
    name: json['name']?.toString() ?? '',
    avatar: json['avatar']?.toString(),
  );
}

class CallInvitedUser extends CallUser {
  const CallInvitedUser({
    required super.id,
    required super.name,
    super.avatar,
    required this.status,
  });

  final CallInviteStatus status;

  factory CallInvitedUser.fromJson(Map<String, dynamic> json) {
    final user = CallUser.fromJson(json);
    return CallInvitedUser(
      id: user.id,
      name: user.name,
      avatar: user.avatar,
      status: _enumValue(json['status']?.toString(), const {
        'pending': CallInviteStatus.pending,
        'accepted': CallInviteStatus.accepted,
        'declined': CallInviteStatus.declined,
      }, CallInviteStatus.unknown),
    );
  }
}

class CallParticipant extends CallUser {
  const CallParticipant({
    required super.id,
    required super.name,
    super.avatar,
    this.joinedAt,
  });

  final DateTime? joinedAt;

  factory CallParticipant.fromJson(Map<String, dynamic> json) {
    final user = CallUser.fromJson(json);
    return CallParticipant(
      id: user.id,
      name: user.name,
      avatar: user.avatar,
      joinedAt: _dateValue(json['joined_at']),
    );
  }
}

class AgoraCredentials {
  const AgoraCredentials({
    required this.appId,
    required this.channel,
    required this.uid,
    required this.token,
    required this.expiresIn,
    required this.expiresAt,
  });

  final String appId;
  final String channel;
  final int uid;
  final String token;
  final int expiresIn;
  final DateTime expiresAt;

  factory AgoraCredentials.fromJson(Map<String, dynamic> json) {
    final expiresAt = _dateValue(json['expires_at']);
    if (expiresAt == null) {
      throw const FormatException('Invalid Agora credentials expiry');
    }
    return AgoraCredentials(
      appId: json['app_id']?.toString() ?? '',
      channel: json['channel']?.toString() ?? '',
      uid: _intValue(json['uid']),
      token: json['token']?.toString() ?? '',
      expiresIn: _intValue(json['expires_in']),
      expiresAt: expiresAt,
    );
  }
}

class CallModel {
  const CallModel({
    required this.id,
    required this.threadId,
    required this.type,
    required this.status,
    this.initiator,
    this.invitedUsers = const [],
    this.participants = const [],
    this.startedAt,
    this.endedAt,
    this.expiresAt,
  });

  final String id;
  final int threadId;
  final CallType type;
  final CallStatus status;
  final CallUser? initiator;
  final List<CallInvitedUser> invitedUsers;
  final List<CallParticipant> participants;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final DateTime? expiresAt;

  factory CallModel.fromJson(Map<String, dynamic> json) {
    final initiator = json['initiator'];
    return CallModel(
      id: json['id']?.toString() ?? '',
      threadId: _intValue(json['thread_id']),
      type: _enumValue(json['type']?.toString(), const {
        'audio': CallType.audio,
        'video': CallType.video,
      }, CallType.unknown),
      status: _enumValue(json['status']?.toString(), const {
        'ringing': CallStatus.ringing,
        'active': CallStatus.active,
        'ended': CallStatus.ended,
      }, CallStatus.unknown),
      initiator: initiator is Map<String, dynamic>
          ? CallUser.fromJson(initiator)
          : null,
      invitedUsers: (json['invited_users'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(CallInvitedUser.fromJson)
          .toList(growable: false),
      participants: (json['participants'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(CallParticipant.fromJson)
          .toList(growable: false),
      startedAt: _dateValue(json['started_at']),
      endedAt: _dateValue(json['ended_at']),
      expiresAt: _dateValue(json['expires_at']),
    );
  }
}

class CallSession {
  const CallSession({required this.call, required this.credentials});

  final CallModel call;
  final AgoraCredentials credentials;

  factory CallSession.fromJson(Map<String, dynamic> json) => CallSession(
    call: CallModel.fromJson(json['call'] as Map<String, dynamic>),
    credentials: AgoraCredentials.fromJson(
      json['credentials'] as Map<String, dynamic>,
    ),
  );
}
