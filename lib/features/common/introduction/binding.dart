import 'package:get/get.dart';
import 'package:sukientotapp/features/common/introduction/controller.dart';

class IntroductionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroductionController>(() => IntroductionController());
  }
}
