import 'package:dio/dio.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/core/utils/logger.dart';
import 'package:sukientotapp/domain/api_url.dart';

class ProfileProvider {
  final ApiService _apiService;

  ProfileProvider(this._apiService);

  Future<Map<String, dynamic>> updateProfile(FormData formData) async {
    try {
      final response = await _apiService.dio.post(
        AppUrl.updateProfile,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to update profile: \${response.statusCode}');
      }
    } on DioException catch (e) {
      logger.e('[ProfileProvider] [updateProfile] DioException: \${e.message}');
      final errorMessage = e.response?.data['message'] ?? 'Failed to update profile';
      throw Exception(errorMessage);
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _apiService.dio.get(AppUrl.profile);
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } on DioException catch (e) {
      logger.e('[ProfileProvider] [getProfile] DioException: ${e.message}');
      final errorMessage = e.response?.data['message'] ?? 'Failed to load profile';
      throw Exception(errorMessage);
    }
  }
}
