import 'package:get/get.dart';
import 'controller.dart';

import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/data/providers/partner/my_services_provider.dart';
import 'package:sukientotapp/data/repositories/partner/my_services_repository_impl.dart';
import 'package:sukientotapp/domain/repositories/partner/my_services_repository.dart';

class MyServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<MyServicesProvider>(() => MyServicesProvider(Get.find<ApiService>()));
    Get.lazyPut<MyServicesRepository>(
      () => MyServicesRepositoryImpl(Get.find<MyServicesProvider>()),
    );
    Get.lazyPut<MyServicesController>(
      () => MyServicesController(Get.find<MyServicesRepository>()),
    );
  }
}