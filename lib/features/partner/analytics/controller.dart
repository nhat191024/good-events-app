import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/core/utils/logger.dart';
import 'package:sukientotapp/data/models/partner/analytics_model.dart';
import 'package:sukientotapp/domain/repositories/partner/analytics_repository.dart';

class AnalyticsController extends GetxController {
  final AnalyticsRepository _repository;
  AnalyticsController(this._repository);

  final isLoading = false.obs;
  final statistics = Rxn<PartnerStatisticsModel>();
  final revenueChart = <RevenueChartEntry>[].obs;
  final topServices = <TopServiceModel>[].obs;
  final refreshController = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<void> onRefresh() async {
    await fetchAll();
    refreshController.refreshCompleted();
  }

  Future<void> fetchAll() async {
    isLoading.value = true;
    try {
      logger.i('[AnalyticsController] [fetchAll] Fetching analytics data...');
      final results = await Future.wait([
        _repository.getStatistics(),
        _repository.getRevenueChart(),
        _repository.getTopServices(),
      ]);
      statistics.value = results[0] as PartnerStatisticsModel;
      revenueChart.value = results[1] as List<RevenueChartEntry>;
      topServices.value = results[2] as List<TopServiceModel>;
      logger.i('[AnalyticsController] [fetchAll] Analytics data loaded successfully.');
    } catch (e) {
      logger.e('[AnalyticsController] [fetchAll] Error: $e');
      AppSnackbar.showError(title: 'error'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
