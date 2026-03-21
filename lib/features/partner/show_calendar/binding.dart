import 'package:get/get.dart';
import 'controller.dart';

import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/data/providers/partner/show_provider.dart';
import 'package:sukientotapp/domain/repositories/partner/show_repository.dart';
import 'package:sukientotapp/data/repositories/partner/show_repository_impl.dart';

class ShowCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);

    Get.lazyPut<ShowProvider>(
      () => ShowProvider(Get.find<ApiService>()),
      fenix: true,
    );

    Get.lazyPut<ShowRepository>(
      () => ShowRepositoryImpl(Get.find<ShowProvider>()),
      fenix: true,
    );

    Get.lazyPut<ShowCalendarController>(
      () => ShowCalendarController(Get.find<ShowRepository>()),
    );
  }
}