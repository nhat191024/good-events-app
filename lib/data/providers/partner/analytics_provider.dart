import 'package:dio/dio.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/core/utils/logger.dart';
import 'package:sukientotapp/domain/api_url.dart';

class AnalyticsProvider {
  final ApiService _apiService;

  AnalyticsProvider(this._apiService);

  Future<Map<String, dynamic>> getStatistics() async {
    try {
      final response = await _apiService.dio.get(
        AppUrl.partnerAnalyticsStatistics,
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
      throw Exception(
        'Failed to load analytics statistics: ${response.statusCode}',
      );
    } on DioException catch (e) {
      logger.e(
        '[AnalyticsProvider] [getStatistics] DioException: ${e.message}',
      );
      if (e.response != null) {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to load analytics statistics',
        );
      }
      throw Exception(
        'Cannot connect to server. Please check your connection.',
      );
    } catch (e) {
      logger.e('[AnalyticsProvider] [getStatistics] Unknown error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getRevenueChart() async {
    try {
      final response = await _apiService.dio.get(
        AppUrl.partnerAnalyticsRevenueChart,
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
      throw Exception('Failed to load revenue chart: ${response.statusCode}');
    } on DioException catch (e) {
      logger.e(
        '[AnalyticsProvider] [getRevenueChart] DioException: ${e.message}',
      );
      if (e.response != null) {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to load revenue chart',
        );
      }
      throw Exception(
        'Cannot connect to server. Please check your connection.',
      );
    } catch (e) {
      logger.e('[AnalyticsProvider] [getRevenueChart] Unknown error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getTopServices() async {
    try {
      final response = await _apiService.dio.get(
        AppUrl.partnerAnalyticsTopServices,
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
      throw Exception('Failed to load top services: ${response.statusCode}');
    } on DioException catch (e) {
      logger.e(
        '[AnalyticsProvider] [getTopServices] DioException: ${e.message}',
      );
      if (e.response != null) {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to load top services',
        );
      }
      throw Exception(
        'Cannot connect to server. Please check your connection.',
      );
    } catch (e) {
      logger.e('[AnalyticsProvider] [getTopServices] Unknown error: $e');
      rethrow;
    }
  }
}
