import 'package:get/get.dart';
import 'controller.dart';
import 'package:sukientotapp/domain/repositories/client/home_repository.dart';

class PartnerDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerDetailController>(
      () => PartnerDetailController(Get.find<HomeRepository>()),
    );
  }
}
