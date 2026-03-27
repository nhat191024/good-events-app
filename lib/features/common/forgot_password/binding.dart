import 'package:get/get.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/data/providers/auth_provider.dart';
import 'package:sukientotapp/data/repositories/common/forgot_password_repository_impl.dart';
import 'package:sukientotapp/domain/repositories/common/forgot_password_repository.dart';
import 'controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<AuthProvider>(() => AuthProvider(Get.find<ApiService>()));
    Get.lazyPut<ForgotPasswordRepository>(
      () => ForgotPasswordRepositoryImpl(Get.find<AuthProvider>()),
    );
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(Get.find<ForgotPasswordRepository>()),
    );
  }
}