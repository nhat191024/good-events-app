import 'package:sukientotapp/core/utils/import/global.dart';

import 'controller.dart';
import 'widget/header.dart';
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
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredMessages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.mail,
                        size: 60,
                        color: AppColors.lightMutedForeground,
                      ),
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
              return SmartRefresher(
                controller: controller.refreshController,
                enablePullDown: true,
                enablePullUp: false,
                header: const ClassicHeader(),
                onRefresh: controller.refreshThreads,
                onLoading: controller.onLoadMore,
                child: ListView.builder(
                  controller: controller.listScrollController,
                  padding: EdgeInsets.zero,
                  itemCount: controller.filteredMessages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == controller.filteredMessages.length) {
                      return Obx(() {
                        if (controller.isLoadingMore.value) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
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
                      });
                    }
                    final message = controller.filteredMessages[index];
                    return Column(
                      children: [
                        if (index != 0)
                          const Divider(
                            color: AppColors.lightBorder,
                            height: 1,
                          ),
                        GestureDetector(
                          onTap: () async {
                            controller.openThread(message);
                            await Get.to<void>(
                              () => const MessageDetailScreen(),
                            );
                            controller.closeThread();
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            message.subject,
                                            style: TextStyle(
                                              color: message.isRead
                                                  ? AppColors.lightForeground
                                                  : AppColors.primary,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          if (message.unreadMessages > 0)
                                            Container(
                                              padding: const EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                color: AppColors.primary,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: RichText(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                children: [
                                                  if (message
                                                          .newestMessageSender !=
                                                      null)
                                                    TextSpan(
                                                      text:
                                                          '${message.newestMessageSender}: ',
                                                      style: TextStyle(
                                                        color: message.isRead
                                                            ? AppColors
                                                                  .lightMutedForeground
                                                            : AppColors.primary,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            message.isRead
                                                            ? FontWeight.normal
                                                            : FontWeight.w500,
                                                      ),
                                                    ),
                                                  TextSpan(
                                                    text:
                                                        message.newestMessage ??
                                                        'no_messages'.tr,
                                                    style: TextStyle(
                                                      color: message.isRead
                                                          ? AppColors
                                                                .lightMutedForeground
                                                          : AppColors.primary,
                                                      fontSize: 13,
                                                      fontWeight: message.isRead
                                                          ? FontWeight.normal
                                                          : FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            message.time,
                                            style: const TextStyle(
                                              color: AppColors
                                                  .lightMutedForeground,
                                              fontSize: 12,
                                            ),
                                          ),
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
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
