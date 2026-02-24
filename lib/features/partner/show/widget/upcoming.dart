import 'dart:ui';

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
          child: Obx(
            () => ListView.builder(
              controller: controller.upcomingScrollController,
              padding: const EdgeInsets.only(
                top: 60, // Add padding to avoid overlap with the glass header
                bottom: 100, // Add padding to avoid navbar overlap
              ),
              itemCount:
                  controller.upcomingItems.length + (controller.isUpcomingLoadMore.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == controller.upcomingItems.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final i = controller.upcomingItems[index];
                return Show(
                  code: '$i',
                  timestamp: '10 Giờ',
                  price: '10 VND',
                  clientName: 'Client $i',
                  category: 'Category $i',
                  event: 'Event $i',
                  date: '0${(i % 9) + 1}-02-2026',
                  startTime: '10:00',
                  endTime: '12:00',
                  address: 'Address $i',
                  note: 'Note $i',
                  currentStatus: 'confirmed',
                );
              },
            ),
          ),
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
