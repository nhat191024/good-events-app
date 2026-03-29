import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/partner/home/controller.dart'; // PartnerHomeController
import 'package:sukientotapp/data/providers/partner/dashboard_provider.dart';
import 'package:sukientotapp/data/repositories/partner/dashboard_repository_impl.dart';
import 'package:sukientotapp/domain/repositories/partner/dashboard_repository.dart';
import 'package:sukientotapp/core/services/api_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardProvider>(
      () => DashboardProvider(Get.find<ApiService>()),
    );
    Get.lazyPut<DashboardRepository>(
      () => DashboardRepositoryImpl(Get.find<DashboardProvider>()),
    );
    Get.lazyPut<PartnerHomeController>(
      () => PartnerHomeController(Get.find<DashboardRepository>()),
    );
  }
}
