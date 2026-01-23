import 'package:get/get.dart';
import 'package:sukientotapp/features/common/choose_yo_side/choose_yo_side_controller.dart';

class ChooseYoSideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseYoSideController>(() => ChooseYoSideController());
  }
}
