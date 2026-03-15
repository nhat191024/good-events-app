import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

import './show.dart';

import 'package:sukientotapp/features/components/button/plus.dart';
import 'package:sukientotapp/features/partner/show/controller.dart';

class UpcomingWidget extends GetView<ShowController> {
  const UpcomingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            if (controller.isUpcomingLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.upcomingBills.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.tray,
                      size: 56,
                      color: context.fTheme.colors.mutedForeground,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'no_bills'.tr,
                      style: context.typography.sm.copyWith(
                        color: context.fTheme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              controller: controller.upcomingScrollController,
              padding: const EdgeInsets.only(top: 60, bottom: 100),
              itemCount:
                  controller.upcomingBills.length +
                  (controller.isUpcomingLoadMore.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == controller.upcomingBills.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final bill = controller.upcomingBills[index];
                return Show(
                  code: bill.code,
                  timestamp: bill.updatedAt,
                  price: bill.finalTotal.toStringAsFixed(0),
                  clientName: bill.clientName,
                  category: bill.category,
                  event: bill.event,
                  date: bill.date,
                  startTime: bill.startTime,
                  endTime: bill.endTime,
                  address: bill.address,
                  note: bill.note ?? '',
                  currentStatus: bill.status,
                );
              },
            );
          }),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: context.fTheme.colors.background.withAlpha(100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButtonPlus(
                      onTap: () => controller.refreshData(),
                      btnText: 'refresh'.tr,
                      textSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 34,
                      borderRadius: 10,
                      borderColor: Colors.transparent,
                      color: AppColors.red600,
                    ),
                    const SizedBox(width: 6),
                    CustomButtonPlus(
                      onTap: () => Get.snackbar('info'.tr, 'in_dev'.tr),
                      icon: FIcons.calendarDays,
                      iconSize: 16,
                      btnText: 'calendar'.tr,
                      textSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 34,
                      borderRadius: 10,
                      borderColor: Colors.transparent,
                    ),
                    const SizedBox(width: 6),
                    CustomButtonPlus(
                      onTap: () => Get.snackbar('info'.tr, 'in_dev'.tr),
                      icon: FIcons.listFilterPlus,
                      iconSize: 16,
                      textSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 34,
                      borderRadius: 10,
                      borderColor: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
