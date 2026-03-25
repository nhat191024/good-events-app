import 'package:dio/dio.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/api_url.dart';

class NotificationProvider {
  final ApiService _apiService;

  NotificationProvider(this._apiService);

  Future<Map<String, dynamic>> getNotifications({required int page}) async {
    try {
      final response = await _apiService.dio.get(
        AppUrl.notifications,
        queryParameters: {'page': page},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      logger.e('[NotificationProvider] [getNotifications] DioException: ${e.message}');
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to fetch notifications');
      }
      throw Exception('Network error. Please check your connection.');
    } catch (e) {
      logger.e('[NotificationProvider] [getNotifications] Unknown error: $e');
      rethrow;
    }
  }

  Future<void> readNotification(String id) async {
    try {
      await _apiService.dio.post(AppUrl.notificationRead(id));
    } on DioException catch (e) {
      logger.e('[NotificationProvider] [readNotification] DioException: ${e.message}');
      // Ignore errors as requested
    } catch (e) {
      logger.e('[NotificationProvider] [readNotification] Unknown error: $e');
    }
  }

  Future<void> readAllNotifications() async {
    try {
      await _apiService.dio.post(AppUrl.notificationsReadAll);
    } on DioException catch (e) {
      logger.e('[NotificationProvider] [readAllNotifications] DioException: ${e.message}');
      // Ignore errors as requested
    } catch (e) {
      logger.e('[NotificationProvider] [readAllNotifications] Unknown error: $e');
    }
  }
}
