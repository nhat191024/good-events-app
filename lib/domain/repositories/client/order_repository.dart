import 'package:sukientotapp/data/models/client/event_order_model.dart';
import 'package:sukientotapp/data/models/client/history_order_model.dart';
import 'package:sukientotapp/data/models/client/order_detail_model.dart';
import 'package:sukientotapp/data/models/client/asset_order_model.dart';

abstract class OrderRepository {
  Future<List<EventOrderModel>> getEventOrders();
  Future<List<HistoryOrderModel>> getHistoryOrders();
  Future<OrderDetailModel?> getOrderDetails(int orderId);
  Future<List<AssetOrderModel>> getAssetOrders();
}
