class MessageListModel {
  final String id;
  final String subject;
  final String name;
  final String? newestMessage;
  final String? newestMessageSender;
  final String time;
  final bool isRead;
  final int unreadMessages;

  MessageListModel({
    required this.id,
    this.subject = '',
    required this.name,
    required this.newestMessage,
    required this.newestMessageSender,
    required this.time,
    required this.isRead,
    required this.unreadMessages,
  });

  factory MessageListModel.fromJson(Map<String, dynamic> json) {
    final participants = json['participants'] as List<dynamic>? ?? [];
    final latestMessage = json['latest_message'] as Map<String, dynamic>?;

    final participantName = participants.isNotEmpty
        ? (participants.first as Map<String, dynamic>)['name'] as String? ?? ''
        : '';

    final isUnread = json['is_unread'] as bool? ?? false;

    return MessageListModel(
      id: json['id'].toString(),
      subject: json['subject'] as String? ?? '',
      name: participantName,
      newestMessage: latestMessage?['body'] as String?,
      newestMessageSender: latestMessage?['sender_name'] as String?,
      time: latestMessage?['created_at'] as String? ?? '',
      isRead: !isUnread,
      unreadMessages: isUnread ? 1 : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'name': name,
      'newestMessage': newestMessage,
      'newestMessageSender': newestMessageSender,
      'time': time,
      'isRead': isRead,
      'unreadMessages': unreadMessages,
    };
  }
}
