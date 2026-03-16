import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/client/event_order_model.dart';
import 'package:sukientotapp/data/models/client/history_order_model.dart';
import 'package:sukientotapp/data/models/client/order_detail_model.dart';
import 'package:sukientotapp/data/models/client/asset_order_model.dart';
import 'package:sukientotapp/data/providers/client/order_provider.dart';
import 'package:sukientotapp/domain/repositories/client/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderProvider _provider;

  OrderRepositoryImpl(this._provider);

  @override
  Future<List<EventOrderModel>> getEventOrders() async {
    try {
      final response = await _provider.getEventOrders();

      if (response != null && response is List) {
        return response.map((json) => EventOrderModel.fromJson(json)).toList();
      } else if (response != null && response['data'] is List) {
        // Handle paginated response if wrapped in 'data'
        return (response['data'] as List).map((json) => EventOrderModel.fromJson(json)).toList();
      }

      return [];
    } catch (e) {
      logger.e('Failed to parse getEventOrders response: $e');
      return [];
    }
  }

  @override
  Future<List<HistoryOrderModel>> getHistoryOrders() async {
    try {
      final response = await _provider.getHistoryOrders();

      if (response != null && response is List) {
        return response.map((json) => HistoryOrderModel.fromJson(json)).toList();
      } else if (response != null && response['data'] is List) {
        // Handle paginated response if wrapped in 'data'
        return (response['data'] as List).map((json) => HistoryOrderModel.fromJson(json)).toList();
      }

      return [];
    } catch (e) {
      logger.e('Failed to parse getHistoryOrders response: $e');
      return [];
    }
  }

  @override
  Future<OrderDetailModel?> getOrderDetails(int orderId) async {
    try {
      final response = await _provider.getOrderDetails(orderId);
      if (response != null && response is Map<String, dynamic>) {
        return OrderDetailModel.fromJson(response);
      }
      return null;
    } catch (e) {
      logger.e('Failed to parse getOrderDetails response: $e');
      return null;
    }
  }

  @override
  Future<EventOrderModel?> getOrder(int orderId) async {
    try {
      final response = await _provider.getOrder(orderId);
      if (response != null && response is Map<String, dynamic>) {
        return EventOrderModel.fromJson(response);
      }
      return null;
    } catch (e) {
      logger.e('Failed to parse getOrder response: $e');
      return null;
    }
  }

  @override
  Future<List<AssetOrderModel>> getAssetOrders() async {
    try {
      final response = await _provider.getAssetOrders();
      if (response != null && response is List) {
        return response
            .map((json) => AssetOrderModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      logger.e('Failed to parse getAssetOrders response: $e');
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>> reportBill({
    required int billId,
    required String title,
    required String description,
  }) async {
    return _provider.reportBill(billId, title, description);
  }

  @override
  Future<Map<String, dynamic>> choosePartner({
    required int orderId,
    required int partnerId,
  }) async {
    try {
      final response = await _provider.choosePartner(orderId, partnerId);
      return response as Map<String, dynamic>;
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  @override
  Future<Map<String, dynamic>> cancelOrder(int orderId) async {
    try {
      final response = await _provider.cancelOrder(orderId);
      return response as Map<String, dynamic>;
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
