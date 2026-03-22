import 'package:sukientotapp/data/models/partner/analytics_model.dart';

abstract class AnalyticsRepository {
  Future<PartnerStatisticsModel> getStatistics();
  Future<List<RevenueChartEntry>> getRevenueChart();
  Future<List<TopServiceModel>> getTopServices();
}
