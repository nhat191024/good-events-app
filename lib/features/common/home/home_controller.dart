import 'package:sukientotapp/core/utils/import/global.dart';

class GuestHomeController extends GetxController {
  var isServiceProvider = Get.arguments['isServiceProvider'] as bool? ?? false;
  RxBool userType = false.obs; // true: customer, false: service provider

  @override
  void onInit() {
    super.onInit();
    userType.value = !isServiceProvider;
  }
}
