import 'package:sukientotapp/data/models/partner/analytics_model.dart';
import 'package:sukientotapp/data/providers/partner/analytics_provider.dart';
import 'package:sukientotapp/domain/repositories/partner/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AnalyticsProvider _provider;

  AnalyticsRepositoryImpl(this._provider);

  @override
  Future<PartnerStatisticsModel> getStatistics() async {
    final data = await _provider.getStatistics();
    return PartnerStatisticsModel.fromMap(data);
  }

  @override
  Future<List<RevenueChartEntry>> getRevenueChart() async {
    final data = await _provider.getRevenueChart();
    final list = data['data'] as List<dynamic>;
    return list
        .map((e) => RevenueChartEntry.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<TopServiceModel>> getTopServices() async {
    final data = await _provider.getTopServices();
    final list = data['data'] as List<dynamic>;
    return list
        .map((e) => TopServiceModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
