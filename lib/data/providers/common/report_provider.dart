import 'package:dio/dio.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/api_url.dart';

class ReportProvider {
  final Dio _dio;

  ReportProvider({required Dio dio}) : _dio = dio;

  Future<Map<String, dynamic>> reportBill({
    required int reportedBillId,
    required String title,
    required String description,
  }) async {
    try {
      final response = await _dio.post(
        AppUrl.reportBill,
        data: {
          'reported_bill_id': reportedBillId,
          'title': title,
          'description': description,
        },
      );
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        return {
          'success': false,
          'message': e.response?.data['message'] ?? 'report_failed'.tr,
          'errors': e.response?.data['errors'] ?? <String, dynamic>{},
        };
      }

      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'network_error'.tr,
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> reportUser({
    required int reportedUserId,
    required String title,
    required String description,
  }) async {
    try {
      final response = await _dio.post(
        AppUrl.reportUser,
        data: {
          'reported_user_id': reportedUserId,
          'title': title,
          'description': description,
        },
      );
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        return {
          'success': false,
          'message': e.response?.data['message'] ?? 'report_failed'.tr,
          'errors': e.response?.data['errors'] ?? <String, dynamic>{},
        };
      }

      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'network_error'.tr,
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
