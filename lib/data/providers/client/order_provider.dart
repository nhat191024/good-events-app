import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/api_url.dart';
import 'package:dio/dio.dart';

class OrderProvider {
  final Dio _dio;

  OrderProvider({required Dio dio}) : _dio = dio;

  Future<dynamic> getEventOrders() async {
    try {
      final response = await _dio.get(AppUrl.clientOrders);
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'fetch_failed'.tr);
      }
      throw Exception('network_error'.tr);
    }
  }

  Future<dynamic> getHistoryOrders() async {
    try {
      final response = await _dio.get(AppUrl.clientHistoryOrders);
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'fetch_failed'.tr);
      }
      throw Exception('network_error'.tr);
    }
  }

  Future<dynamic> getOrderDetails(int orderId) async {
    try {
      final response = await _dio.get(AppUrl.clientOrderDetail(orderId));
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'fetch_failed'.tr);
      }
      throw Exception('network_error'.tr);
    }
  }

  Future<dynamic> getOrder(int orderId) async {
    try {
      final response = await _dio.get(AppUrl.clientOrder(orderId));
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'fetch_failed'.tr);
      }
      throw Exception('network_error'.tr);
    }
  }

  Future<dynamic> getAssetOrders() async {
    try {
      final response = await _dio.get(AppUrl.clientAssetOrders);
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'fetch_failed'.tr);
      }
      throw Exception('network_error'.tr);
    }
  }

  Future<Map<String, dynamic>> reportBill(int billId, String title, String description) async {
    try {
      final response = await _dio.post(
        AppUrl.reportBill,
        data: {
          'reported_bill_id': billId,
          'title': title,
          'description': description,
        },
      );
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == 422) {
        return {
          'success': false,
          'message': e.response?.data['message'] ?? 'fetch_failed'.tr,
          'errors': e.response?.data['errors'] ?? {},
        };
      }
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'network_error'.tr,
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  Future<dynamic> choosePartner(int orderId, int partnerId) async {
    try {
      final response = await _dio.post(
        AppUrl.choosePartner,
        data: {
          'order_id': orderId,
          'partner_id': partnerId,
        },
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 422) {
          final errors = e.response?.data['errors'];
          if (errors != null) {
            final firstErrorMsg = errors.values.first.first;
            throw Exception(firstErrorMsg);
          }
        }
        throw Exception(e.response?.data['message'] ?? 'choose_partner_failed'.tr);
      }
      throw Exception('network_error'.tr);
    }
  }

  Future<dynamic> cancelOrder(int orderId) async {
    try {
      final response = await _dio.post(
        AppUrl.cancelOrder,
        data: {
          'order_id': orderId,
        },
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'cancel_failed'.tr);
      }
      throw Exception('network_error'.tr);
    }
  }
}
