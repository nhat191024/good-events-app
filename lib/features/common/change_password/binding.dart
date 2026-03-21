import 'package:get/get.dart';
import 'controller.dart';

import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/data/providers/common/profile_provider.dart';
import 'package:sukientotapp/domain/repositories/common/change_password_repository.dart';
import 'package:sukientotapp/data/repositories/common/change_password_repository_impl.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<ProfileProvider>(() => ProfileProvider(Get.find<ApiService>()));
    Get.lazyPut<ChangePasswordRepository>(
      () => ChangePasswordRepositoryImpl(Get.find<ProfileProvider>()),
    );
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(Get.find<ChangePasswordRepository>()),
    );
  }
}
