import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/repositories/partner/dashboard_repository.dart';
import 'package:sukientotapp/data/models/partner/dashboard_model.dart';

class PartnerHomeController extends GetxController {
  final DashboardRepository _dashboardRepository;

  PartnerHomeController(this._dashboardRepository);

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

  RxInt balance = RxInt(
    (StorageService.readMapData(
              key: LocalStorageKeys.user,
              mapKey: 'wallet_balance',
            )
            as int?) ??
        0,
  );

  RxBool isLoading = true.obs;
  Rxn<DashboardModel> dashboardData = Rxn<DashboardModel>();

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  void syncFromStorage() {
    name.value =
        (StorageService.readMapData(
                  key: LocalStorageKeys.user,
                  mapKey: 'name',
                ) ??
                '')
            .toString();
    avatar.value =
        (StorageService.readMapData(
                  key: LocalStorageKeys.user,
                  mapKey: 'avatar_url',
                ) ??
                '')
            .toString();
  }

  void syncBalance() {
    balance.value =
        (StorageService.readMapData(
                  key: LocalStorageKeys.user,
                  mapKey: 'wallet_balance',
                ) ??
                0)
            .toInt();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      final data = await _dashboardRepository.getDashboardData();
      dashboardData.value = data;
    } catch (e) {
      logger.e('[PartnerHomeController] [fetchDashboardData] error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
