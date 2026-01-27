import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/core/services/localstorage_service.dart';
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

    logger.i('[SplashController] [_checkToken] Starting token check');

    final token = StorageService.readData(key: LocalStorageKeys.token);

    if (token == null) {
      logger.w('[SplashController] [_checkToken] No token found, redirecting to choose side');
      Get.offAllNamed(Routes.chooseYoSideScreen);
      return;
    }

    try {
      final isTokenValid = await _authRepository.checkToken();

      if (isTokenValid) {
        logger.i('[SplashController] [_checkToken] Token valid, redirecting to home');
        // TODO: Navigate to appropriate home screen based on user role
        // Get.offAllNamed(Routes.clientHome); or Get.offAllNamed(Routes.partnerHome);
        Get.offAllNamed(Routes.chooseYoSideScreen);
      } else {
        logger.w('[SplashController] [_checkToken] Token invalid, clearing storage');
        StorageService.removeData(key: LocalStorageKeys.token);
        StorageService.removeData(key: LocalStorageKeys.user);
        Get.offAllNamed(Routes.chooseYoSideScreen);
      }
    } catch (e) {
      logger.e('[SplashController] [_checkToken] Error checking token: $e');
      StorageService.removeData(key: LocalStorageKeys.token);
      StorageService.removeData(key: LocalStorageKeys.user);
      Get.offAllNamed(Routes.chooseYoSideScreen);
    }
  }
}
