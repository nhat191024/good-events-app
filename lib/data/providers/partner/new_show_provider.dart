import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/domain/api_url.dart';

class NewShowProvider {
  final ApiService _apiService;

  NewShowProvider(this._apiService);

  Future<Map<String, dynamic>> getRealtimeBills({int page = 1}) async {
    final response = await _apiService.dio.get(
      AppUrl.partnerBillsRealtime,
      queryParameters: {'page': page},
    );

    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load realtime bills');
    }
  }
}
