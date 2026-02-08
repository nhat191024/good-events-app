import 'package:get/get.dart';
import 'controller.dart';

class PartnerDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerDetailController>(() => PartnerDetailController());
  }
}
