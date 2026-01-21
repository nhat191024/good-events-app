import 'package:get/get.dart';

import 'package:sukientotapp/core/service/api_service.dart';
import 'package:sukientotapp/core/service/localstorage_service.dart';

class SplashController extends GetxController {
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    _checkToken();
  }

  Future<void> _checkToken() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final token = StorageService.readData(key: LocalStorageKeys.token);

    if (token == null) {
      // Get.offAll(() => const LoginScreen());
      return;
    }

    try {
      // await _apiService.dio.get('/check-token');
      // Get.offAll(() => const BranchListScreen());
    } catch (e) {
      StorageService.removeData(key: LocalStorageKeys.token);
      StorageService.removeData(key: LocalStorageKeys.user);
      // Get.offAll(() => const LoginScreen());
    }
  }
}
