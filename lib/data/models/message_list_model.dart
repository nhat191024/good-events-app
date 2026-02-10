class MessageListModel {
  final String id;
  final String avatar;
  final String name;
  final String newestMessage;
  final String time;
  final bool isRead;
  final int unreadMessages;

  MessageListModel({
    required this.id,
    required this.avatar,
    required this.name,
    required this.newestMessage,
    required this.time,
    required this.isRead,
    required this.unreadMessages,
  });

  factory MessageListModel.fromJson(Map<String, dynamic> json) {
    return MessageListModel(
      id: json['id'] ?? '',
      avatar: json['avatar'] ?? '',
      name: json['name'] ?? '',
      newestMessage: json['newestMessage'] ?? '',
      time: json['time'] ?? '',
      isRead: json['isRead'] ?? false,
      unreadMessages: json['unreadMessages'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatar': avatar,
      'name': name,
      'newestMessage': newestMessage,
      'time': time,
      'isRead': isRead,
      'unreadMessages': unreadMessages,
    };
  }
}
