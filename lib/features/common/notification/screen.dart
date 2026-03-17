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
            icon: const Icon(Icons.close),
            onPress: () => Get.back(),
          ),
        ],
      ),
      child: Column(
        children: [
          TabBar(
            controller: controller.tabController,
            labelColor: context.primary,
            unselectedLabelColor: context.fTheme.colors.mutedForeground,
            labelStyle: context.typography.base.copyWith(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: context.typography.sm,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: 'conversations'.tr),
              Tab(text: 'orders'.tr),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _buildTabContent(context, controller.conversations),
                _buildTabContent(context, controller.orders),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, RxList<NotificationItem> items) {
    return Obx(() {
      if (items.isEmpty) {
        return Center(
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
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (context, index) => const Divider(
          height: 20,
          color: Colors.transparent,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return Row(
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
                  item.icon,
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
                        Text(
                          item.title,
                          style: context.typography.base.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item.time,
                          style: context.typography.xs.copyWith(
                            color: context.fTheme.colors.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.message,
                      style: context.typography.sm.copyWith(
                        color: context.fTheme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
