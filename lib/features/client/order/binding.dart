import 'package:get/get.dart';
import 'controller.dart';

class ClientOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientOrderController>(() => ClientOrderController());
  }
}
