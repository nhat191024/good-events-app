import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/partner/bottom_navigation/bottom_navigation_controller.dart';

import 'package:sukientotapp/features/partner/home/home_controller.dart';

class PartnerBottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerBottomNavigationController>(
      () => PartnerBottomNavigationController(),
    );
    
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
