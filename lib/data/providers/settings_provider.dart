import 'package:dio/dio.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/core/utils/logger.dart';
import 'package:sukientotapp/domain/api_url.dart';

class SettingsProvider {
  final ApiService _apiService;

  SettingsProvider(this._apiService);

  /// Fetch app settings
  /// GET /settings
  Future<Map<String, dynamic>> fetchSettings() async {
    try {
      final response = await _apiService.dio.get(AppUrl.settings);

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception(
          'Fetch settings failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      logger.e('[SettingsProvider] [fetchSettings] DioException: ${e.message}');
      if (e.response != null) {
        final errorMessage =
            e.response?.data['message'] ?? 'Fetch settings failed';
        throw Exception(errorMessage);
      } else {
        throw Exception(
          'Không thể kết nối đến server. Vui lòng kiểm tra mạng.',
        );
      }
    } catch (e) {
      logger.e('[SettingsProvider] [fetchSettings] Unknown error: $e');
      throw Exception('Đã xảy ra lỗi: $e');
    }
  }
}
