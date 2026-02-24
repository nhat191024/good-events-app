import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

import './widgets/show.dart';

import 'package:sukientotapp/features/components/button/plus.dart';
import 'package:sukientotapp/features/components/button/circle.dart';

class NewShowScreen extends GetView<NewShowController> {
  const NewShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: Padding(
        padding: EdgeInsets.only(top: context.statusBarHeight, left: 16, right: 16),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'last_update'.trParams({'time': '5 phút trước'}),
                  style: context.typography.sm.copyWith(
                    color: context.fTheme.colors.mutedForeground,
                  ),
                ),
                CustomButtonPlus(
                  onTap: () {}, //TODO: Refresh action
                  btnText: 'refresh'.tr,
                  textSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 34,
                  borderRadius: 10,
                  borderColor: Colors.transparent,
                  color: AppColors.red600,
                ),
              ],
            ),
          ],
        ),
      ),
      child: Obx(
        () => ListView.builder(
          controller: controller.scrollController,
          padding: const EdgeInsets.only(top: 12, bottom: 100),
          itemCount: controller.items.length + (controller.isLoadMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.items.length) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final i = controller.items[index];
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
            );
          },
        ),
      ),
    );
  }
}
