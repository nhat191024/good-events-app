import 'package:sukientotapp/core/utils/import/global.dart';

import 'controller.dart';
import './widget/header.dart';
import 'detail_screen.dart';

class MessageScreen extends GetView<MessageController> {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      childPad: false,
      header: Header(controller: controller),
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.filteredMessages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.mail, size: 60, color: AppColors.lightMutedForeground),
                      const SizedBox(height: 20),
                      Text(
                        'no_messages'.tr,
                        style: const TextStyle(
                          color: AppColors.lightForeground,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.filteredMessages.length + 1,
                itemBuilder: (context, index) {
                  if (index == controller.filteredMessages.length) {
                    return Column(
                      children: [
                        const Divider(color: AppColors.lightBorder),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Text(
                              'no_further_messages'.tr,
                              style: const TextStyle(
                                color: AppColors.lightMutedForeground,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  final message = controller.filteredMessages[index];
                  return Column(
                    children: [
                      if (index != 0) const Divider(color: AppColors.lightBorder, height: 1),
                      GestureDetector(
                        onTap: () {
                          controller.id = message.id;
                          Get.to(() => const MessageDetailScreen());
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              CircleAvatar(radius: 30, backgroundImage: AssetImage(message.avatar)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          message.name,
                                          style: TextStyle(
                                            color: message.isRead
                                                ? AppColors.lightForeground
                                                : AppColors.primary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          message.time,
                                          style: const TextStyle(
                                            color: AppColors.lightMutedForeground,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            message.newestMessage,
                                            style: TextStyle(
                                              color: message.isRead
                                                  ? AppColors.lightMutedForeground
                                                  : AppColors.primary,
                                              fontSize: 13,
                                              fontWeight: message.isRead
                                                  ? FontWeight.normal
                                                  : FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        if (message.unreadMessages > 0) ...[
                                          Container(
                                            padding: const EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text(
                                              message.unreadMessages.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
