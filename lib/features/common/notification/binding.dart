import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/notification/controller.dart';
import 'package:sukientotapp/data/providers/common/notification_provider.dart';
import 'package:sukientotapp/domain/repositories/common/notification_repository.dart';
import 'package:sukientotapp/data/repositories/common/notification_repository_impl.dart';
import 'package:sukientotapp/domain/repositories/client/order_repository.dart';
import 'package:sukientotapp/data/repositories/client/order_repository_impl.dart';
import 'package:sukientotapp/data/providers/client/order_provider.dart';
import 'package:sukientotapp/core/services/api_service.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationProvider>(() => NotificationProvider(Get.find<ApiService>()));
    Get.lazyPut<NotificationRepository>(
      () => NotificationRepositoryImpl(Get.find<NotificationProvider>()),
    );
    Get.lazyPut<OrderProvider>(() => OrderProvider(dio: Get.find<ApiService>().dio));
    Get.lazyPut<OrderRepository>(
      () => OrderRepositoryImpl(Get.find<OrderProvider>()),
    );
    Get.lazyPut<NotificationController>(
      () => NotificationController(
        Get.find<NotificationRepository>(),
        Get.find<OrderRepository>(),
      ),
    );
  }
}
