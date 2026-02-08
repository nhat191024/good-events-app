import 'package:sukientotapp/core/utils/import/global.dart';

import './show.dart';

import 'package:sukientotapp/features/components/button/plus.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
            for (int i = 0; i < 3; i++)
              Show(
                code: '$i',
                timestamp: '10 Giờ',
                price: '10 VND',
                clientName: 'Client $i',
                category: 'Category $i',
                event: 'Event $i',
                date: '0${i + 1}-02-2026',
                startTime: '10:00',
                endTime: '12:00',
                address: 'Address $i',
                note: 'Note $i',
                currentStatus: 'completed',
              ),
          ],
        ),
      ),
    );
  }
}
