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
}
