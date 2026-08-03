class ChatUserSearchResult {
  const ChatUserSearchResult({
    required this.id,
    required this.name,
    required this.phone,
  });

  final int id;
  final String name;
  final String phone;

  factory ChatUserSearchResult.fromJson(Map<String, dynamic> json) {
    return ChatUserSearchResult(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
    );
  }
}

enum ChatInvitationStatus { pending, accepted, left }

class ChatInvitationModel {
  const ChatInvitationModel({
    required this.id,
    required this.threadId,
    required this.userId,
    required this.invitedByUserId,
    required this.status,
    this.acceptedAt,
    this.leftAt,
  });

  final int id;
  final int threadId;
  final int userId;
  final int invitedByUserId;
  final ChatInvitationStatus status;
  final DateTime? acceptedAt;
  final DateTime? leftAt;

  factory ChatInvitationModel.fromJson(Map<String, dynamic> json) {
    return ChatInvitationModel(
      id: json['id'] as int,
      threadId: json['thread_id'] as int,
      userId: json['user_id'] as int,
      invitedByUserId: json['invited_by_user_id'] as int,
      status: ChatInvitationStatus.values.firstWhere(
        (value) => value.name == json['status'],
        orElse: () => ChatInvitationStatus.pending,
      ),
      acceptedAt: DateTime.tryParse(json['accepted_at'] as String? ?? ''),
      leftAt: DateTime.tryParse(json['left_at'] as String? ?? ''),
    );
  }
}

class ChatInvitationResponse {
  const ChatInvitationResponse({required this.message, required this.invitation});

  final String message;
  final ChatInvitationModel invitation;

  factory ChatInvitationResponse.fromJson(Map<String, dynamic> json) {
    return ChatInvitationResponse(
      message: json['message'] as String? ?? '',
      invitation: ChatInvitationModel.fromJson(
        json['invitation'] as Map<String, dynamic>,
      ),
    );
  }
}
