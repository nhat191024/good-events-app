import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

import './widgets/show.dart';

import 'package:sukientotapp/features/components/button/circle.dart';

class NewShowScreen extends GetView<NewShowController> {
  const NewShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: Padding(
        padding: EdgeInsets.only(
          top: context.statusBarHeight,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'new_show'.tr,
                  textAlign: TextAlign.left,
                  style: context.typography.xl2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.fTheme.colors.foreground,
                  ),
                ),
                const Spacer(),
                CircleButton(
                  icon: FIcons.listFilter,
                  onPressed: () => {},
                  size: 34,
                  backgroundColor: context.primary,
                ),
              ],
            ),

            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'last_update'.trParams({
                      'time': controller.lastUpdated.value.isEmpty
                          ? '...'
                          : controller.lastUpdated.value,
                    }),
                    style: context.typography.sm.copyWith(
                      color: context.fTheme.colors.mutedForeground,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.fetchRealtimeBills(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.red600.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.red600.withValues(alpha: 0.35),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FIcons.refreshCw,
                            size: 13,
                            color: AppColors.red600,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'refresh'.tr,
                            style: context.typography.xs.copyWith(
                              color: AppColors.red600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      child: Obx(() {
        if (controller.isLoading.value && controller.bills.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          controller: controller.scrollController,
          padding: const EdgeInsets.only(top: 12, bottom: 100),
          itemCount:
              controller.bills.length + (controller.isLoading.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.bills.length) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final bill = controller.bills[index];
            return Show(
              billId: bill.id,
              code: bill.code,
              timestamp: bill.createdAt,
              price: bill.finalTotal != null
                  ? '${bill.finalTotal!.toStringAsFixed(0)} VND'
                  : 'Chưa có',
              clientName: bill.clientName,
              category: bill.categoryName,
              event: bill.eventName,
              date: bill.date,
              startTime: bill.startTime,
              endTime: bill.endTime,
              address: bill.address,
              note: bill.note ?? 'unknown',
            );
          },
        );
      }),
    );
  }
}
