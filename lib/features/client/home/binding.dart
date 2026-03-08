import 'package:get/get.dart';
import 'controller.dart';

import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/domain/repositories/client/home_repository.dart';
import 'package:sukientotapp/data/repositories/client/home_repository_impl.dart';
import 'package:sukientotapp/data/providers/client/home_provider.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);

    Get.lazyPut<HomeProvider>(
      () => HomeProvider(dio: Get.find<ApiService>().dio),
    );

    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(Get.find<HomeProvider>()),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<HomeRepository>()),
    );
  }
}
