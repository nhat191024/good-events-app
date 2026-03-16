import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/message_model.dart'; // Correct import

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final bool isFirst;

  const ChatBubble({super.key, required this.message, this.isFirst = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isFirst
          ? const EdgeInsets.only(top: 10)
          : const EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment: message.isSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Align(
            alignment: message.isSender
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!message.isSender)
                    Text(
                      message.sender,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message.isSender
                          ? AppColors.primary
                          : AppColors.lightBackground,
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomRight: message.isSender
                            ? const Radius.circular(0)
                            : null,
                        bottomLeft: !message.isSender
                            ? const Radius.circular(0)
                            : null,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message.text,
                          style: TextStyle(
                            color: message.isSender
                                ? Colors.white
                                : Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: message.isSender ? 0 : 16,
              right: message.isSender ? 16 : 0,
              bottom: 4,
            ),
            child: Text(
              message.time,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
