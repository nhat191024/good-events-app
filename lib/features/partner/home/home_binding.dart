import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/partner/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
