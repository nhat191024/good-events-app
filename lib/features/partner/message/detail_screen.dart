import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';
import 'widget/chat_app_bar.dart';
import 'widget/chat_bubble.dart';
import 'widget/chat_input.dart';

class MessageDetailScreen extends GetView<MessageController> {
  const MessageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const ChatAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.messagesDetail.length,
                itemBuilder: (context, index) {
                  final message = controller.messagesDetail[index];
                  return ChatBubble(
                    message: message,
                    isFirst: index == 0,
                  );
                },
              );
            }),
          ),
          ChatInput(controller: controller),
        ],
      ),
    );
  }
}
