import 'package:sukientotapp/data/models/partner/partner_bill_model.dart';

abstract class NewShowRepository {
  Future<RealtimeBillsResponse> getRealtimeBills({int page = 1});
  Future<void> acceptBill({required int billId, required double price});
}
