import 'package:get/get.dart';
import 'controller.dart';

class ClientBookingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientBookingController>(() => ClientBookingController());
  }
}
