import 'package:get/get.dart';
import 'controller.dart';

import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/data/providers/partner/show_provider.dart';
import 'package:sukientotapp/domain/repositories/partner/show_repository.dart';
import 'package:sukientotapp/data/repositories/partner/show_repository_impl.dart';

class ShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);

    Get.lazyPut<ShowProvider>(
      () => ShowProvider(Get.find<ApiService>()),
    );

    Get.lazyPut<ShowRepository>(
      () => ShowRepositoryImpl(Get.find<ShowProvider>()),
    );

    Get.lazyPut<ShowController>(
      () => ShowController(Get.find<ShowRepository>()),
    );
  }
}

