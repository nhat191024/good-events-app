import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/notification/controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: Text('notifications'.tr),
        suffixes: [
          FHeaderAction(
            icon: const Icon(Icons.done_all),
            onPress: () => controller.readAll(),
          ),
          FHeaderAction(
            icon: const Icon(Icons.close),
            onPress: () => Get.back(),
          ),
        ],
      ),
      child: _buildTabContent(context),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.notifications.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.notifications.isEmpty) {
        return SmartRefresher(
          controller: controller.refreshController,
          onRefresh: () => controller.fetchNotifications(isRefresh: true),
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_none,
                      size: 64,
                      color: context.fTheme.colors.mutedForeground,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'no_notifications'.tr,
                      style: context.typography.lg.copyWith(
                        color: context.fTheme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }

      return SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () => controller.fetchNotifications(isRefresh: true),
        onLoading: () => controller.fetchNotifications(),
        enablePullUp: true,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          separatorBuilder: (context, index) =>
              const Divider(height: 20, color: Colors.transparent),
          itemBuilder: (context, index) {
            final item = controller.notifications[index];
            return Material(
              color: item.unread
                  ? context.primary.withAlpha(10)
                  : Colors.transparent,
              child: InkWell(
                onTap: () => controller.readNotification(item),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: context.primary.withAlpha(25),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.notifications,
                          color: context.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.title,
                                    style: context.typography.base.copyWith(
                                      fontWeight: item.unread
                                          ? FontWeight.w900
                                          : FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _formatDate(item.createdAt),
                                  style: context.typography.xs.copyWith(
                                    color:
                                        context.fTheme.colors.mutedForeground,
                                    fontWeight: item.unread
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.message,
                              style: context.typography.sm.copyWith(
                                color: item.unread
                                    ? context.fTheme.colors.foreground
                                    : context.fTheme.colors.mutedForeground,
                                fontWeight: item.unread
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (item.unread) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(top: 6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.primary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes <= 1) return 'just_now'.tr;
        return 'minute_ago'.trParams({'count': '${difference.inMinutes}'});
      }
      return 'hour_ago'.trParams({'count': '${difference.inHours}'});
    } else if (difference.inDays < 7) {
      return 'day_ago'.trParams({'count': '${difference.inDays}'});
    }

    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
  }
}
