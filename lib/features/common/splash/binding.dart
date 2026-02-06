import 'package:get/get.dart';
import 'package:sukientotapp/features/common/splash/controller.dart';
import 'package:sukientotapp/data/repositories/auth_repository_impl.dart';
import 'package:sukientotapp/data/providers/auth_provider.dart';
import 'package:sukientotapp/domain/repositories/auth_repository.dart';
import 'package:sukientotapp/core/services/api_service.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<AuthProvider>(() => AuthProvider(Get.find<ApiService>()));
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find<AuthProvider>()));
    Get.put<SplashController>(SplashController(Get.find<AuthRepository>()));
  }
}
