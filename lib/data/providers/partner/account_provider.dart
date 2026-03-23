import 'package:dio/dio.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/core/utils/logger.dart';
import 'package:sukientotapp/domain/api_url.dart';

class AccountProvider {
  final ApiService _apiService;

  AccountProvider(this._apiService);

  Future<List<Map<String, dynamic>>> getWalletTransactions() async {
    try {
      final response = await _apiService.dio.get(
        AppUrl.partnerWalletTransactions,
      );
      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
        return data.cast<Map<String, dynamic>>();
      }
      throw Exception(
        'Failed to load wallet transactions: ${response.statusCode}',
      );
    } on DioException catch (e) {
      logger.e(
        '[AccountProvider] [getWalletTransactions] DioException: ${e.message}',
      );
      if (e.response != null) {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to load wallet transactions',
        );
      }
      throw Exception(
        'Cannot connect to server. Please check your connection.',
      );
    }
  }

  Future<void> logout() async {
    try {
      final response = await _apiService.dio.get(AppUrl.logout);
      if (response.statusCode != 200) {
        throw Exception('Logout failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      logger.e('[AccountProvider] [logout] DioException: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('unauthorized');
      }
      throw Exception(
        e.response?.data['message'] ?? 'Cannot connect to server.',
      );
    }
  }
}
