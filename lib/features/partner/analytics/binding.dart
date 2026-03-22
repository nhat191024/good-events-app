import 'package:get/get.dart';
import 'controller.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/data/providers/partner/analytics_provider.dart';
import 'package:sukientotapp/domain/repositories/partner/analytics_repository.dart';
import 'package:sukientotapp/data/repositories/partner/analytics_repository_impl.dart';

class AnalyticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<AnalyticsProvider>(
      () => AnalyticsProvider(Get.find<ApiService>()),
    );
    Get.lazyPut<AnalyticsRepository>(
      () => AnalyticsRepositoryImpl(Get.find<AnalyticsProvider>()),
    );
    Get.lazyPut<AnalyticsController>(
      () => AnalyticsController(Get.find<AnalyticsRepository>()),
    );
  }
}
