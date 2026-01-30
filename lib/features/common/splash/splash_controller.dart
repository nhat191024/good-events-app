import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/repositories/auth_repository.dart';

//TODO: update splash in future for now just a placeholder
class SplashController extends GetxController {
  final AuthRepository _authRepository;

  SplashController(this._authRepository);

  @override
  void onInit() {
    super.onInit();
    _checkToken();
  }

  ///Check token validity
  Future<void> _checkToken() async {
    await Future.delayed(const Duration(seconds: 3));

    final token = StorageService.readData(key: LocalStorageKeys.token);

    if (token == null) {
      logger.w('[SplashController] [_checkToken] No token found, redirecting to choose side');
      Get.offAllNamed(Routes.chooseYoSideScreen);
      return;
    }

    try {
      final isTokenValid = await _authRepository.checkToken();

      if (isTokenValid) {
        var role = StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'role');
        switch (role) {
          case 'client':
            Get.snackbar('notification'.tr, 'in_dev'.tr);
            return;
          case 'partner':
            Get.offAllNamed(Routes.partnerHome);
            return;
        }
      } else {
        logger.w('[SplashController] [_checkToken] Token invalid, clearing storage');
        StorageService.removeData(key: LocalStorageKeys.token);
        StorageService.removeData(key: LocalStorageKeys.user);
        Get.offAllNamed(Routes.chooseYoSideScreen);
      }
    } catch (e) {
      StorageService.removeData(key: LocalStorageKeys.token);
      StorageService.removeData(key: LocalStorageKeys.user);
      Get.offAllNamed(Routes.chooseYoSideScreen);
    }
  }
}
