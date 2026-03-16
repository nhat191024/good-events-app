class MessageModel {
  final int? id;
  final String sender;
  final String text;
  final bool isSender;
  final bool sended;
  final String time;
  final String date;

  MessageModel({
    this.id,
    this.sender = '',
    required this.text,
    required this.isSender,
    required this.sended,
    required this.time,
    required this.date,
  });

  /// Converts an ISO 8601 timestamp string to a human-readable relative time.
  static String _diffForHumans(String isoString) {
    if (isoString.isEmpty) return '';
    final DateTime? dateTime = DateTime.tryParse(isoString);
    if (dateTime == null) return isoString;
    final Duration diff = DateTime.now().difference(dateTime);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) {
      final m = diff.inMinutes;
      return '$m ${m == 1 ? 'minute' : 'minutes'} ago';
    }
    if (diff.inHours < 24) {
      final h = diff.inHours;
      return '$h ${h == 1 ? 'hour' : 'hours'} ago';
    }
    if (diff.inDays < 30) {
      final d = diff.inDays;
      return '$d ${d == 1 ? 'day' : 'days'} ago';
    }
    if (diff.inDays < 365) {
      final mo = (diff.inDays / 30).floor();
      return '$mo ${mo == 1 ? 'month' : 'months'} ago';
    }
    final y = (diff.inDays / 365).floor();
    return '$y ${y == 1 ? 'year' : 'years'} ago';
  }

  factory MessageModel.fromApiJson(
    Map<String, dynamic> json, {
    required int? currentUserId,
  }) {
    final senderId = json['sender_id'] as int?;
    final message = json['message'] as Map<String, dynamic>? ?? {};
    final user = json['user'] as Map<String, dynamic>? ?? {};
    final createdAt = message['created_at'] as String? ?? '';
    return MessageModel(
      id: message['id'] as int?,
      sender: user['name'] as String? ?? '',
      text: message['body'] as String? ?? '',
      isSender: currentUserId != null && senderId == currentUserId,
      sended: true,
      time: _diffForHumans(createdAt),
      date: '',
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'] ?? '',
      isSender: json['isSender'] ?? false,
      sended: json['sended'] ?? false,
      time: json['time'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isSender': isSender,
      'sended': sended,
      'time': time,
      'date': date,
    };
  }
}
