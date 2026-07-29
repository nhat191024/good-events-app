import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/bottom_navigation/controller.dart';

import 'package:sukientotapp/features/client/home/screen.dart';
import 'package:sukientotapp/features/client/order/screen.dart';
import 'package:sukientotapp/features/common/message/screen.dart';
import 'package:sukientotapp/features/common/account/screen.dart';

class ClientBottomNavigationView
    extends GetView<ClientBottomNavigationController> {
  const ClientBottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          child: CurvedNavigationBar(
            index: controller.currentIndex.value,
            onTap: (index) => controller.setIndex(index),
            color: AppColors.primary,
            buttonBackgroundColor: AppColors.red600,
            backgroundColor: Colors.transparent,
            animationDuration: Duration(milliseconds: 500),
            height: context.height * 0.07,
            items: [
              _buildNavItem(
                FIcons.house,
                'home'.tr,
                0,
                controller.currentIndex.value,
              ),
              _buildNavItem(
                FIcons.calendars,
                'orders'.tr,
                1,
                controller.currentIndex.value,
              ),
              _buildNavItem(
                FIcons.messageSquareText,
                'messages'.tr,
                2,
                controller.currentIndex.value,
              ),
              _buildNavItem(
                FIcons.userRound,
                'account'.tr,
                3,
                controller.currentIndex.value,
              ),
            ],
            animationCurve: Curves.fastOutSlowIn,
          ),
        ),
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            HomeScreen(),
            ClientOrderScreen(),
            MessageScreen(),
            AccountScreen(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    int index,
    int currentIndex,
  ) {
    final isSelected = index == currentIndex;
    if (isSelected) {
      return Icon(icon, size: 24, color: Colors.white);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: Colors.white),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
