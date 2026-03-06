import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/repositories/partner/dashboard_repository.dart';
import 'package:sukientotapp/data/models/partner/dashboard_model.dart';
import 'package:sukientotapp/core/utils/logger.dart';

class HomeController extends GetxController {
  final DashboardRepository _dashboardRepository;

  HomeController(this._dashboardRepository);

  RxString name =
      (StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'name') ??
              '')
          .toString()
          .obs;
  RxString avatar =
      (StorageService.readMapData(
                key: LocalStorageKeys.user,
                mapKey: 'avatar_url',
              ) ??
              '')
          .toString()
          .obs;

  RxBool isLoading = true.obs;
  Rxn<DashboardModel> dashboardData = Rxn<DashboardModel>();

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      final data = await _dashboardRepository.getDashboardData();
      dashboardData.value = data;
    } catch (e) {
      logger.e('[HomeController] [fetchDashboardData] error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
