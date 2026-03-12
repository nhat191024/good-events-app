import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

class ClientAssetOrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientAssetOrderDetailController>(
      () => ClientAssetOrderDetailController(),
    );
  }
}
