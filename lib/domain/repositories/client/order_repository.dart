import 'package:sukientotapp/data/models/client/event_order_model.dart';
import 'package:sukientotapp/data/models/client/history_order_model.dart';
import 'package:sukientotapp/data/models/client/order_detail_model.dart';
import 'package:sukientotapp/data/models/client/asset_order_model.dart';

abstract class OrderRepository {
  Future<({List<EventOrderModel> data, int lastPage})> getEventOrders({int page = 1});
  Future<({List<HistoryOrderModel> data, int lastPage})> getHistoryOrders({int page = 1});
  Future<EventOrderModel?> getOrder(int orderId);
  Future<OrderDetailModel?> getOrderDetails(int orderId);
  Future<List<AssetOrderModel>> getAssetOrders();
  Future<Map<String, dynamic>> reportBill({
    required int billId,
    required String title,
    required String description,
  });
  Future<Map<String, dynamic>> choosePartner({
    required int orderId,
    required int partnerId,
  });
  Future<Map<String, dynamic>> cancelOrder(int orderId);
  Future<Map<String, dynamic>> submitReview({
    required int orderId,
    required int partnerId,
    required int rating,
    String? comment,
  });
}
