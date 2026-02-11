import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/bottom_navigation/controller.dart';
import 'package:sukientotapp/features/client/home/binding.dart';
import 'package:sukientotapp/features/client/partner_detail/binding.dart';
import 'package:sukientotapp/features/client/booking/binding.dart';
import 'package:sukientotapp/features/client/order/binding.dart';

class ClientBottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientBottomNavigationController>(() => ClientBottomNavigationController());

    HomeBinding().dependencies();
    ClientBookingBinding().dependencies();
    ClientOrderBinding().dependencies();
  }
}
