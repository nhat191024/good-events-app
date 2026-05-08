import 'package:dio/dio.dart';
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

  Future<String?> acceptBill({required int billId, required double price}) async {
    try {
      final response = await _apiService.dio.post(
        AppUrl.partnerBillAccept(billId),
        data: {'price': price},
      );
      return response.statusCode == 200 ? null : 'UNKNOWN_ERROR';
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        return data['code'] as String? ?? 'UNKNOWN_ERROR';
      }
      return 'UNKNOWN_ERROR';
    }
  }
}
