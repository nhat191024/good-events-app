import 'package:dio/dio.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/core/utils/logger.dart';
import 'package:sukientotapp/domain/api_url.dart';

class AuthProvider {
  final ApiService _apiService;

  AuthProvider(this._apiService);

  /// Login API call
  /// POST /auth/login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _apiService.dio.post(
        AppUrl.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      logger.e('[AuthProvider] [login] DioException: ${e.message}');

      if (e.response != null) {
        final errorMessage = e.response?.data['message'] ?? 'Login failed';
        throw Exception(errorMessage);
      } else {
        throw Exception(
          'Không thể kết nối đến server. Vui lòng kiểm tra mạng.',
        );
      }
    } catch (e) {
      logger.e('[AuthProvider] [login] Unknown error: $e');
      throw Exception('Đã xảy ra lỗi: $e');
    }
  }

  /// Google Login API call
  /// POST /login/google
  Future<Map<String, dynamic>> loginWithGoogle(String accessToken) async {
    try {
      final response = await _apiService.dio.post(
        AppUrl.loginGoogle,
        data: {'access_token': accessToken},
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Google login failed with status: \${response.statusCode}');
      }
    } on DioException catch (e) {
      logger.e('[AuthProvider] [loginWithGoogle] DioException: \${e.message}');

      if (e.response != null) {
        final errorMessage = e.response?.data['message'] ?? 'Google login failed';
        throw Exception(errorMessage);
      } else {
        throw Exception(
          'Không thể kết nối đến server. Vui lòng kiểm tra mạng.',
        );
      }
    } catch (e) {
      logger.e('[AuthProvider] [loginWithGoogle] Unknown error: $e');
      throw Exception('Đã xảy ra lỗi: $e');
    }
  }

  /// Client Registration API call
  /// POST /register
  Future<Map<String, dynamic>> registerClient(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.dio.post(
        AppUrl.registerClient,
        data: data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception(
          'Registration failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      logger.e('[AuthProvider] [registerClient] DioException: ${e.message}');
      if (e.response != null) {
        final errorMessage =
            e.response?.data['message'] ?? 'Registration failed';
        throw Exception(errorMessage);
      } else {
        throw Exception(
          'Không thể kết nối đến server. Vui lòng kiểm tra mạng.',
        );
      }
    } catch (e) {
      logger.e('[AuthProvider] [registerClient] Unknown error: $e');
      throw Exception('Đã xảy ra lỗi: $e');
    }
  }

  /// Partner Registration API call
  /// POST /register/partner
  Future<Map<String, dynamic>> registerPartner(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.dio.post(
        AppUrl.registerPartner,
        data: data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception(
          'Registration failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      logger.e('[AuthProvider] [registerPartner] DioException: ${e.message}');
      if (e.response != null) {
        final errorMessage =
            e.response?.data['message'] ?? 'Registration failed';
        throw Exception(errorMessage);
      } else {
        throw Exception(
          'Không thể kết nối đến server. Vui lòng kiểm tra mạng.',
        );
      }
    } catch (e) {
      logger.e('[AuthProvider] [registerPartner] Unknown error: $e');
      throw Exception('Đã xảy ra lỗi: $e');
    }
  }

  /// Check Token Validity API call
  /// GET /check-token
  Future<bool> checkToken() async {
    try {
      final response = await _apiService.dio.get(AppUrl.checkToken);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      logger.e('[AuthProvider] [checkToken] DioException: ${e.message}');

      if (e.response?.statusCode == 401) {
        return false;
      }

      throw Exception('Không thể xác thực token. Vui lòng thử lại.');
    } catch (e) {
      logger.e('[AuthProvider] [checkToken] Unknown error: $e');
      throw Exception('Đã xảy ra lỗi khi kiểm tra token: $e');
    }
  }

  Future<bool> logout() async {
    try {
      final response = await _apiService.dio.get(AppUrl.logout);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      logger.e('[AuthProvider] [logout] DioException: ${e.message}');

      if (e.response?.statusCode == 401) {
        return false;
      }

      throw Exception('Không thể đăng xuất. Vui lòng thử lại.');
    } catch (e) {
      logger.e('[AuthProvider] [logout] Unknown error: $e');
      throw Exception('Đã xảy ra lỗi khi đăng xuất: $e');
    }
  }
}
