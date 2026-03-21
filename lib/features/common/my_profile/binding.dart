import 'package:get/get.dart';
import 'controller.dart';

import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/data/providers/common/profile_provider.dart';
import 'package:sukientotapp/domain/repositories/common/my_profile_repository.dart';
import 'package:sukientotapp/data/repositories/common/my_profile_repository_impl.dart';

class MyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<ProfileProvider>(() => ProfileProvider(Get.find<ApiService>()));
    Get.lazyPut<MyProfileRepository>(
      () => MyProfileRepositoryImpl(Get.find<ProfileProvider>()),
    );
    Get.lazyPut<MyProfileController>(
      () => MyProfileController(Get.find<MyProfileRepository>()),
    );
  }
}