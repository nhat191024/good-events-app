import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/partner/bottom_navigation/controller.dart';

import 'package:sukientotapp/features/partner/home/screen.dart';
import 'package:sukientotapp/features/partner/show/screen.dart';

class PartnerBottomNavigationView extends GetView<PartnerBottomNavigationController> {
  const PartnerBottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: controller.currentIndex.value,
          onTap: (index) => controller.setIndex(index),
          color: AppColors.primary,
          buttonBackgroundColor: AppColors.primary,
          backgroundColor: Colors.transparent,
          animationDuration: Duration(milliseconds: 400),
          height: context.height * 0.07,
          items: [
            Icon(FIcons.house, size: 24, color: Colors.white),
            Icon(FIcons.calendar1, size: 24, color: Colors.white),
            Icon(FIcons.calendarPlus, size: 24, color: Colors.white),
            Icon(FIcons.messageSquareText, size: 24, color: Colors.white),
            Icon(FIcons.userRound, size: 24, color: Colors.white),
          ],
        ),
        //FadeThroughTransition option. Use this if SharedAxisTransition case laggy problem (because Obx)
        // body: Obx(
        //   () => PageTransitionSwitcher(
        //     duration: const Duration(milliseconds: 600),
        //     transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        //       return FadeThroughTransition(
        //         animation: primaryAnimation,
        //         secondaryAnimation: secondaryAnimation,
        //         child: child,
        //       );
        //     },
        //     child: _buildContent(),
        //   ),
        // ),
        body: Obx(
          () => PageTransitionSwitcher(
            duration: const Duration(milliseconds: 600),
            reverse: controller.isReverse.value,
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              return SharedAxisTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (controller.currentIndex.value) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ShowScreen();
      default:
        return const HomeScreen();
    }
  }
}
