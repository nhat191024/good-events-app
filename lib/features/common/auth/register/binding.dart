import 'package:get/get.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/data/providers/auth_provider.dart';
import 'package:sukientotapp/data/repositories/auth_repository_impl.dart';
import 'package:sukientotapp/domain/repositories/auth_repository.dart';
import 'package:sukientotapp/data/providers/location_provider.dart';
import 'package:sukientotapp/data/repositories/location_repository_impl.dart';
import 'package:sukientotapp/domain/repositories/location_repository.dart';
import 'package:sukientotapp/features/common/auth/register/controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // Auth Dependencies
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<AuthProvider>(() => AuthProvider(Get.find<ApiService>()));
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find<AuthProvider>()));

    // Location Dependencies
    Get.lazyPut<LocationProvider>(() => LocationProvider(Get.find<ApiService>()));
    Get.lazyPut<LocationRepository>(() => LocationRepositoryImpl(Get.find<LocationProvider>()));

    Get.lazyPut<RegisterController>(
      () => RegisterController(
        Get.find<AuthRepository>(),
        Get.find<LocationRepository>(),
      ),
    );
  }
}
