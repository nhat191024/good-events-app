import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/partner/bottom_navigation/bottom_navigation_controller.dart';

import 'package:sukientotapp/features/partner/home/home.dart';

class PartnerBottomNavigationView extends GetView<PartnerBottomNavigationController> {
  const PartnerBottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FScaffold(
        footer: FBottomNavigationBar(
          index: controller.currentIndex.value,
          onChange: (index) => controller.setIndex(index),
          children: [
            FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('home'.tr)),
            FBottomNavigationBarItem(icon: Icon(FIcons.calendar1), label: Text('bills'.tr)),
            FBottomNavigationBarItem(icon: Icon(FIcons.calendarPlus), label: Text('take_order'.tr)),
            FBottomNavigationBarItem(icon: Icon(FIcons.messageSquareText), label: Text('messages'.tr)),
            FBottomNavigationBarItem(icon: Icon(FIcons.userRound), label: Text('account'.tr)),
          ],
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    switch (controller.currentIndex.value) {
      case 0:
        return const HomeScreen();
      default:
        return const HomeScreen();
    }
  }
}
