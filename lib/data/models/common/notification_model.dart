class NotificationModel {
  final String id;
  final String title;
  final String message;
  bool unread;
  final DateTime createdAt;
  final int? orderId;
  final String? href;
  final Map<String, dynamic> data;
  final Map<String, dynamic> payload;
  final String? type;
  final int? threadId;
  final int? invitationId;
  final int? inviterId;
  final String? inviterName;

  bool get isChatInvitation =>
      type == 'chat_invitation' && threadId != null && invitationId != null;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.unread,
    required this.createdAt,
    this.orderId,
    this.href,
    this.data = const {},
    this.payload = const {},
    this.type,
    this.threadId,
    this.invitationId,
    this.inviterId,
    this.inviterName,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final data = _asMap(json['data']) ?? <String, dynamic>{};
    final payload =
        _asMap(json['payload']) ??
        _asMap(data['payload']) ??
        <String, dynamic>{};
    final href =
        _nonEmptyString(json['href']) ??
        _nonEmptyString(data['href']) ??
        _nonEmptyString(payload['href']);
    final type =
        _nonEmptyString(json['type']) ??
        _nonEmptyString(data['type']) ??
        _nonEmptyString(payload['type']);
    final inviter =
        _asMap(json['inviter']) ??
        _asMap(data['inviter']) ??
        _asMap(payload['inviter']);
    final inviterName = inviter?['name']?.toString();
    final isChatInvitation = type == 'chat_invitation';
    final title =
        _nonEmptyString(json['title']) ??
        _nonEmptyString(data['title']) ??
        (isChatInvitation ? 'Lời mời tham gia đoạn chat' : '');
    final message =
        _nonEmptyString(json['message']) ??
        _nonEmptyString(data['message']) ??
        (isChatInvitation
            ? inviterName == null || inviterName.isEmpty
                  ? 'Bạn được mời tham gia một đoạn chat.'
                  : '$inviterName đã mời bạn tham gia một đoạn chat.'
            : '');

    return NotificationModel(
      id: json['id']?.toString() ?? '',
      title: title,
      message: message,
      unread: json['unread'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at']).toLocal()
          : DateTime.now(),
      orderId: _extractOrderId(json, data, payload, href),
      href: href,
      data: data,
      payload: payload,
      type: type,
      threadId:
          _toInt(json['thread_id']) ??
          _toInt(data['thread_id']) ??
          _toInt(payload['thread_id']),
      invitationId:
          _toInt(json['invitation_id']) ??
          _toInt(data['invitation_id']) ??
          _toInt(payload['invitation_id']),
      inviterId: _toInt(inviter?['id']),
      inviterName: inviterName,
    );
  }

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  static String? _nonEmptyString(dynamic value) {
    final string = value?.toString().trim();
    return string == null || string.isEmpty ? null : string;
  }

  static int? _extractOrderId(
    Map<String, dynamic> json,
    Map<String, dynamic> data,
    Map<String, dynamic> payload,
    String? href,
  ) {
    final directId =
        _toInt(json['order_id']) ??
        _toInt(json['bill_id']) ??
        _toInt(json['partner_bill_id']) ??
        _toInt(data['order_id']) ??
        _toInt(data['bill_id']) ??
        _toInt(data['partner_bill_id']) ??
        _toInt(payload['order_id']) ??
        _toInt(payload['bill_id']) ??
        _toInt(payload['partner_bill_id']);
    if (directId != null) return directId;

    final actionUrl = href ?? _firstActionUrl(payload);
    if (actionUrl == null || actionUrl.isEmpty) return null;

    final uri = Uri.tryParse(actionUrl);
    final queryId = uri == null
        ? null
        : _toInt(uri.queryParameters['order']) ??
              _toInt(uri.queryParameters['order_id']) ??
              _toInt(uri.queryParameters['bill_id']) ??
              _toInt(uri.queryParameters['partner_bill_id']);
    if (queryId != null) return queryId;

    final match = RegExp(r'(?:orders?|bills?)/(\d+)').firstMatch(actionUrl);
    return _toInt(match?.group(1));
  }

  static String? _firstActionUrl(Map<String, dynamic> payload) {
    final actions = payload['actions'];
    if (actions is! List) return null;

    for (final action in actions) {
      if (action is Map && action['url'] != null) {
        return action['url'].toString();
      }
    }
    return null;
  }

  static int? _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}
