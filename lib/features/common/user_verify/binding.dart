import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/user_verify/controller.dart';

class UserVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserVerifyController>(() => UserVerifyController());
  }
}
