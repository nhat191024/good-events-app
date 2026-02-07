import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/repositories/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository;

  LoginController(this._authRepository);

  final loginFormKey = GlobalKey<FormState>();

  // TextEditingControllers for input fields
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onClose() {
    super.onClose();
    usernameController.dispose();
    passwordController.dispose();
  }

  Future<void> login() async {
    loginFormKey.currentState!.save();

    if (!loginFormKey.currentState!.validate()) {
      debugPrint('Login form is invalid');
      return;
    }

    try {
      isLoading.value = true;
      final user = await _authRepository.login(usernameController.text, passwordController.text);
      Get.snackbar('success'.tr, 'login_successful'.trParams({'name': user.name}));
      await Future.delayed(const Duration(seconds: 1));

      var role = StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'role');
      switch (role) {
        case 'client':
          Get.offAllNamed(Routes.clientHome);
          break;
        case 'partner':
          Get.offAllNamed(Routes.partnerHome);
          break;
      }
    } catch (e) {
      Get.snackbar('error'.tr, e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
