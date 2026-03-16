import 'package:get/get.dart';
import 'controller.dart';

import 'package:sukientotapp/data/providers/client/order_provider.dart';
import 'package:sukientotapp/data/repositories/client/order_repository_impl.dart';
import 'package:sukientotapp/core/services/api_service.dart';

class ClientOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<OrderProvider>(() => OrderProvider(dio: Get.find<ApiService>().dio));
    Get.lazyPut<OrderRepositoryImpl>(() => OrderRepositoryImpl(Get.find()));
    Get.lazyPut<ClientOrderController>(
      () => ClientOrderController(Get.find<OrderRepositoryImpl>()),
    );
  }
}
