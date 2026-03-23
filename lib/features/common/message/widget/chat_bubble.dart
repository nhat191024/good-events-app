import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/message_model.dart'; // Correct import

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final bool isFirst;

  const ChatBubble({super.key, required this.message, this.isFirst = false});

  @override
  Widget build(BuildContext context) {
    final isSender = message.isSender;
    return Padding(
      padding: EdgeInsets.fromLTRB(12, isFirst ? 12 : 2, 12, 2),
      child: Column(
        crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isSender)
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 3),
              child: Text(
                message.sender,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (isSender)
                Padding(
                  padding: const EdgeInsets.only(right: 6, bottom: 2),
                  child: Text(
                    message.time,
                    style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                  ),
                ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.72,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSender ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isSender ? 18 : 4),
                      bottomRight: Radius.circular(isSender ? 4 : 18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.07),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: isSender ? Colors.white : const Color(0xFF1F2937),
                      fontSize: 14,
                      height: 1.45,
                    ),
                  ),
                ),
              ),
              if (!isSender)
                Padding(
                  padding: const EdgeInsets.only(left: 6, bottom: 2),
                  child: Text(
                    message.time,
                    style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
