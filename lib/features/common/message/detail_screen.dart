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
              if (controller.isLoadingMessages.value &&
                  controller.messagesDetail.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  Obx(() {
                    if (!controller.isLoadingOlderMessages.value) {
                      return const SizedBox.shrink();
                    }
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }),
                  Expanded(
                    child: ListView.builder(
                      controller: controller.scrollController,
                      reverse: true,
                      itemCount: controller.messagesDetail.length,
                      itemBuilder: (context, index) {
                        final message = controller.messagesDetail[index];
                        return ChatBubble(
                          message: message,
                          isFirst: index == controller.messagesDetail.length - 1,
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
          ChatInput(controller: controller),
        ],
      ),
    );
  }
}
