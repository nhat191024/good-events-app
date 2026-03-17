import 'package:sukientotapp/core/utils/import/global.dart';

class MessageModel {
  final int? id;
  final int? threadId;
  final String sender;
  final String text;
  final bool isSender;
  final bool sended;
  final String time;
  final String date;

  MessageModel({
    this.id,
    this.sender = '',
    this.threadId,
    required this.text,
    required this.isSender,
    required this.sended,
    required this.time,
    required this.date,
  });

  /// Converts an ISO 8601 timestamp string to a human-readable relative time.
  static String diffForHumans(String isoString) {
    if (isoString.isEmpty) return '';
    final DateTime? dateTime = DateTime.tryParse(isoString);
    if (dateTime == null) return isoString;
    final Duration diff = DateTime.now().difference(dateTime);
    if (diff.inSeconds < 60) return 'just_now'.tr;
    if (diff.inMinutes < 60) {
      final m = diff.inMinutes;
      return (m == 1 ? 'minute_ago' : 'minutes_ago').trParams({'count': '$m'});
    }
    if (diff.inHours < 24) {
      final h = diff.inHours;
      return (h == 1 ? 'hour_ago' : 'hours_ago').trParams({'count': '$h'});
    }
    if (diff.inDays < 30) {
      final d = diff.inDays;
      return (d == 1 ? 'day_ago' : 'days_ago').trParams({'count': '$d'});
    }
    if (diff.inDays < 365) {
      final mo = (diff.inDays / 30).floor();
      return (mo == 1 ? 'month_ago' : 'months_ago').trParams({'count': '$mo'});
    }
    final y = (diff.inDays / 365).floor();
    return (y == 1 ? 'year_ago' : 'years_ago').trParams({'count': '$y'});
  }

  factory MessageModel.fromApiJson(
    Map<String, dynamic> json, {
    required int? currentUserId,
  }) {
    final senderId = json['sender_id'] as int?;
    final message = json['message'] as Map<String, dynamic>? ?? {};
    final threadId = message['thread_id'] as int?;
    final user = json['user'] as Map<String, dynamic>? ?? {};
    final createdAt = message['created_at'] as String? ?? '';
    return MessageModel(
      id: message['id'] as int?,
      threadId: threadId,
      sender: user['name'] as String? ?? '',
      text: message['body'] as String? ?? '',
      isSender: currentUserId != null && senderId == currentUserId,
      sended: true,
      time: diffForHumans(createdAt),
      date: '',
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      threadId: json['threadId'] as int?,
      text: json['text'] ?? '',
      isSender: json['isSender'] ?? false,
      sended: json['sended'] ?? false,
      time: json['time'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'threadId': threadId,
      'text': text,
      'isSender': isSender,
      'sended': sended,
      'time': time,
      'date': date,
    };
  }
}
