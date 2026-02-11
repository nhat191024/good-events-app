import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/partner/bottom_navigation/controller.dart';

import 'package:sukientotapp/features/partner/home/binding.dart';
import 'package:sukientotapp/features/partner/show/binding.dart';
import 'package:sukientotapp/features/partner/message/binding.dart';
import 'package:sukientotapp/features/partner/account/binding.dart';

class PartnerBottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerBottomNavigationController>(() => PartnerBottomNavigationController());

    HomeBinding().dependencies();
    ShowBinding().dependencies();
    MessageBinding().dependencies();
    AccountBinding().dependencies();
  }
}
