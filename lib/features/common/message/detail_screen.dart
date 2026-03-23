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
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: const ChatAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoadingMessages.value &&
                  controller.messagesDetail.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 2,
                  ),
                );
              }
              return Column(
                children: [
                  Obx(() {
                    if (!controller.isLoadingOlderMessages.value) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }),
                  Expanded(
                    child: ListView.builder(
                      controller: controller.scrollController,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: controller.messagesDetail.length,
                      itemBuilder: (context, index) {
                        final message = controller.messagesDetail[index];
                        return ChatBubble(
                              message: message,
                              isFirst:
                                  index == controller.messagesDetail.length - 1,
                            )
                            .animate(delay: (50 * index).ms)
                            .fadeIn(duration: 500.ms)
                            .slideY(
                              begin: -0.02,
                              end: 0,
                              curve: Curves.easeOut,
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
