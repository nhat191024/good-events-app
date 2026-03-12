import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/providers/client/order_provider.dart';
import 'package:sukientotapp/data/repositories/client/order_repository_impl.dart';
import 'package:sukientotapp/domain/repositories/client/order_repository.dart';
import 'package:dio/dio.dart';
import 'controller.dart';

class ClientOrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderProvider>(() => OrderProvider(dio: Get.find<Dio>()));
    Get.lazyPut<OrderRepository>(() => OrderRepositoryImpl(Get.find<OrderProvider>()));
    Get.lazyPut<ClientOrderDetailController>(
      () => ClientOrderDetailController(Get.find<OrderRepository>()),
    );
  }
}
