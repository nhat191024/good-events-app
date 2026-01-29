import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/repositories/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository;

  LoginController(this._authRepository);

  final loginFormKey = GlobalKey<FormState>();

  var username = ''.obs;
  var password = ''.obs;

  final isLoading = false.obs;

  @override
  void onClose() {
    super.onClose();
    username.close();
    password.close();
  }

  Future<void> login() async {
    loginFormKey.currentState!.save();

    if (!loginFormKey.currentState!.validate()) {
      debugPrint('Login form is invalid');
      return;
    }

    try {
      isLoading.value = true;
      logger.i('[Auth] [Login] Attempting login for ${username.value}');

      final user = await _authRepository.login(username.value, password.value);

      logger.i('[Auth] [Login] Login successful: ${user.name}');

      Get.snackbar('success'.tr, 'login_successful'.trParams({'0': user.name}));
      await Future.delayed(const Duration(seconds: 1));

      var role = StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'role');
      switch (role) {
        case 'client':
          Get.snackbar('notification'.tr, 'in_dev'.tr);
          break;
        case 'partner':
          Get.offAllNamed(Routes.partnerHome);
          break;
      }
    } catch (e) {
      logger.e('[Auth] [Login] Login failed: $e');
      Get.snackbar('error'.tr, e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
