import 'package:get/get.dart';
import 'package:sukientotapp/features/common/home/controller.dart';

class GuestHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuestHomeController>(() => GuestHomeController());
  }
}
