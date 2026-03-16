import 'package:dio/dio.dart';
import 'package:sukientotapp/domain/api_url.dart';

class BookingProvider {
  final Dio _dio;

  BookingProvider({required Dio dio}) : _dio = dio;

  Future<List<Map<String, dynamic>>> getEventTypes() async {
    try {
      final response = await _dio.get(AppUrl.quickBookingEventList);
      if (response.data is List) {
        return (response.data as List).map((item) => item as Map<String, dynamic>).toList();
      }
      return [];
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'fetch_failed');
      }
      throw Exception('network_error');
    }
  }

  Future<Map<String, dynamic>> saveBookingInfo(Map<String, dynamic> payload) async {
    try {
      final response = await _dio.post(
        AppUrl.quickBookingSave,
        data: payload,
      );
      return {
        'success': true,
        ...response.data,
      };
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == 422) {
        return {
          'success': false,
          'message': e.response?.data['message'] ?? 'booking_failed',
          'errors': e.response?.data['errors'] ?? {},
        };
      }
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'network_error',
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}
