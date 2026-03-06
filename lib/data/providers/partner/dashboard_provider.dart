import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/domain/api_url.dart';

class DashboardProvider {
  final ApiService _apiService;

  DashboardProvider(this._apiService);

  Future<Map<String, dynamic>> getDashboardData() async {
    final response = await _apiService.dio.get(AppUrl.partnerDashboard);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load dashboard data');
    }
  }
}
