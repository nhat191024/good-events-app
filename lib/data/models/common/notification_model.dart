class NotificationModel {
  final String id;
  final String title;
  final String message;
  bool unread;
  final DateTime createdAt;
  final int? orderId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.unread,
    required this.createdAt,
    this.orderId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      unread: json['unread'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at']).toLocal()
          : DateTime.now(),
      orderId: json['order_id'],
    );
  }
}
