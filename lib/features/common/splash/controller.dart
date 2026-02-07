import 'dart:async';

import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/core/utils/app_videos.dart';
import 'package:sukientotapp/domain/repositories/auth_repository.dart';
import 'package:video_player/video_player.dart';

//TODO: update splash in future for now just a placeholder
class SplashController extends GetxController {
  final AuthRepository _authRepository;

  SplashController(this._authRepository);

  late VideoPlayerController videoPlayerController;
  RxBool isVideoInitialized = false.obs;
  final Completer<void> _videoCompleter = Completer<void>();

  final bool isDarkMode = Get.isDarkMode;

  @override
  void onInit() {
    super.onInit();

    // Apply saved locale if any
    final saved = StorageService.readMapData(key: LocalStorageKeys.locale);
    if (saved is Map<String, dynamic>) {
      final code = (saved['languageCode'] ?? 'vi') as String;
      final country = (saved['countryCode'] ?? (code == 'vi' ? 'VN' : 'US')) as String;
      Get.updateLocale(Locale(code, country));
    }

    _initVideo();
    _checkToken();
  }

  @override
  void onClose() {
    /// mem leak ;)
    videoPlayerController.dispose();
    super.onClose();
  }

  void _initVideo() async {
    videoPlayerController = VideoPlayerController.asset(
      isDarkMode ? AppVideos.splashVideoDark : AppVideos.splashVideoLight,
    );
    await videoPlayerController.initialize();
    isVideoInitialized.value = true;
    logger.i('preparing to play video');
    videoPlayerController.play();

    videoPlayerController.addListener(() {
      logger.i('videoPlayerController is playing');
      if (videoPlayerController.value.position >= videoPlayerController.value.duration) {
        if (!_videoCompleter.isCompleted) {
          logger.w('video completed');
          _videoCompleter.complete();
        }
      }
    });
  }

  ///Check token validity
  Future<void> _checkToken() async {
    // this equals 2.71 seconds
    await _videoCompleter.future;

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
            Get.offAllNamed(Routes.clientHome);
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
