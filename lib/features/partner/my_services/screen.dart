import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/partner/service_model.dart';
import 'controller.dart';

class MyServicesScreen extends GetView<MyServicesController> {
  const MyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FScaffold(
          header: FHeader.nested(
            title: Text('my_services'.tr),
            prefixes: [FHeaderAction.back(onPress: () => Get.back())],
          ),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return SmartRefresher(
              controller: controller.refreshController,
              enablePullDown: true,
              enablePullUp: false,
              header: const ClassicHeader(),
              onRefresh: controller.onRefresh,
              child: controller.services.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FIcons.briefcase,
                            size: 64,
                            color: context.fTheme.colors.mutedForeground,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'no_services'.tr,
                            style: context.typography.base.copyWith(
                              color: context.fTheme.colors.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                      itemCount: controller.services.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final service = controller.services[index];
                        return ServiceCard(
                          service: service,
                          onEdit: () => controller.openEditSheet(service),
                          onManageMedia: () =>
                              controller.openManageMediaSheet(service),
                        );
                      },
                    ),
            );
          }),
        ),
        Positioned(
          bottom: 24,
          right: 24,
          child: FloatingActionButton.extended(
            onPressed: () => Get.find<MyServicesController>().openAddSheet(),
            backgroundColor: context.fTheme.colors.primary,
            foregroundColor: context.fTheme.colors.primaryForeground,
            icon: const Icon(FIcons.plus),
            label: Text('add_service'.tr),
          ),
        ),
      ],
    );
  }
}

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback? onEdit;
  final VoidCallback? onManageMedia;

  const ServiceCard({
    super.key,
    required this.service,
    this.onEdit,
    this.onManageMedia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.category,
                      style: context.typography.base.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    StatusBadge(status: service.status),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Row(
                children: [
                  Tooltip(
                    message: 'manage_media'.tr,
                    child: IconButton.outlined(
                      onPressed: onManageMedia,
                      icon: Icon(
                        FIcons.image,
                        size: 18,
                        color: context.fTheme.colors.foreground,
                      ),
                      style: IconButton.styleFrom(
                        side: BorderSide(color: context.fTheme.colors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Tooltip(
                    message: 'edit'.tr,
                    child: IconButton.outlined(
                      onPressed: service.isEditable ? onEdit : null,
                      icon: Icon(
                        FIcons.pencil,
                        size: 18,
                        color: service.isEditable
                            ? context.fTheme.colors.primary
                            : context.fTheme.colors.mutedForeground,
                      ),
                      style: IconButton.styleFrom(
                        side: BorderSide(
                          color: service.isEditable
                              ? context.fTheme.colors.primary
                              : context.fTheme.colors.mutedForeground,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final Color bgColor;
    final Color textColor;
    final String label;

    switch (status) {
      case 'approved':
        bgColor = const Color(0xFFD1FAE5);
        textColor = const Color(0xFF065F46);
        label = 'approved'.tr;
      case 'rejected':
        bgColor = const Color(0xFFFEE2E2);
        textColor = const Color(0xFF991B1B);
        label = 'rejected'.tr;
      default: // pending
        bgColor = const Color(0xFFFEF3C7);
        textColor = const Color(0xFF92400E);
        label = 'pending'.tr;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: context.typography.xs.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
