import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/core/services/localstorage_service.dart';

import 'package:sukientotapp/core/routes/pages.dart';

//TODO: update splash in future for now just a placeholder
class SplashController extends GetxController {
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    _checkToken();
  }

  ///Check token validity
  Future<void> _checkToken() async {
    await Future.delayed(const Duration(seconds: 3));

    Get.offAllNamed(Routes.chooseYoSideScreen); //for dev only

    // final token = StorageService.readData(key: LocalStorageKeys.token);

    // if (token == null) {
    // Get.offAll(() => const LoginScreen());
    // return;
    // }

    try {
      // await _apiService.dio.get('/check-token');
      // await Future.delayed(const Duration(seconds: 3));
    } catch (e) {
      StorageService.removeData(key: LocalStorageKeys.token);
      StorageService.removeData(key: LocalStorageKeys.user);
      // Get.offAll(() => const LoginScreen());
    }
  }
}
