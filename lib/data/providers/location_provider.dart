import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/domain/api_url.dart';

class LocationProvider {
  final ApiService _apiService;

  LocationProvider(this._apiService);

  Future<List<dynamic>> getProvinces() async {
    final response = await _apiService.dio.get(AppUrl.locations);
    return response.data as List<dynamic>;
  }

  Future<List<dynamic>> getWards(int provinceId) async {
    final response = await _apiService.dio.get(AppUrl.wards(provinceId));
    return response.data as List<dynamic>;
  }
}
