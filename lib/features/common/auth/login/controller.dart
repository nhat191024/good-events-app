import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository;

  LoginController(this._authRepository);

  final loginFormKey = GlobalKey<FormState>();

  // TextEditingControllers for input fields
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isGoogleLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initGoogleSignIn();
  }

  Future<void> _initGoogleSignIn() async {
    try {
      await GoogleSignIn.instance.initialize();
    } catch (_) {
      // Already initialized
    }
  }

  @override
  void onClose() {
    super.onClose();
    usernameController.dispose();
    passwordController.dispose();
  }

  Future<void> loginWithGoogle() async {
    try {
      isGoogleLoading.value = true;

      final googleUser = await GoogleSignIn.instance.authenticate();
      final authorization = await googleUser.authorizationClient
          .authorizeScopes(['email', 'profile']);
      final accessToken = authorization.accessToken;

      final user = await _authRepository.loginWithGoogle(accessToken);
      Get.snackbar(
        'success'.tr,
        'login_successful'.trParams({'name': user.name}),
      );
      await PusherService.init();
      await NotificationService.init();
      await Future.delayed(const Duration(seconds: 1));

      final role = StorageService.readMapData(
        key: LocalStorageKeys.user,
        mapKey: 'role',
      );
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
      isGoogleLoading.value = false;
    }
  }

  Future<void> login() async {
    loginFormKey.currentState!.save();

    if (!loginFormKey.currentState!.validate()) {
      debugPrint('Login form is invalid');
      return;
    }

    try {
      isLoading.value = true;
      final user = await _authRepository.login(
        usernameController.text,
        passwordController.text,
      );
      Get.snackbar(
        'success'.tr,
        'login_successful'.trParams({'name': user.name}),
      );
      await PusherService.init();
      await NotificationService.init();
      await Future.delayed(const Duration(seconds: 1));

      var role = StorageService.readMapData(
        key: LocalStorageKeys.user,
        mapKey: 'role',
      );
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
