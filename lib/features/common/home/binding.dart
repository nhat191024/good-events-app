import 'package:get/get.dart';
import 'package:sukientotapp/features/common/home/home_controller.dart';

class GuestHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuestHomeController>(() => GuestHomeController());
  }
}
