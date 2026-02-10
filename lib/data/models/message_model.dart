class MessageModel {
  final String text;
  final bool isSender;
  final bool sended;
  final String time;
  final String date;
  final bool isFile;
  final String fileUrl;
  final String fileSize;
  final String fileExtension;

  MessageModel({
    required this.text,
    required this.isSender,
    required this.sended,
    required this.time,
    required this.date,
    this.isFile = false,
    this.fileUrl = '',
    this.fileSize = '',
    this.fileExtension = '',
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'] ?? '',
      isSender: json['isSender'] ?? false,
      sended: json['sended'] ?? false,
      time: json['time'] ?? '',
      date: json['date'] ?? '',
      isFile: json['isFile'] ?? false,
      fileUrl: json['fileUrl'] ?? '',
      fileSize: json['fileSize'] ?? '',
      fileExtension: json['fileExtension'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isSender': isSender,
      'sended': sended,
      'time': time,
      'date': date,
      'isFile': isFile,
      'fileUrl': fileUrl,
      'fileSize': fileSize,
      'fileExtension': fileExtension,
    };
  }
}
