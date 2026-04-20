import 'package:sukientotapp/data/models/partner/partner_bill_model.dart';
import 'package:sukientotapp/data/providers/partner/new_show_provider.dart';
import 'package:sukientotapp/domain/repositories/partner/new_show_repository.dart';

class NewShowRepositoryImpl implements NewShowRepository {
  final NewShowProvider _provider;

  NewShowRepositoryImpl(this._provider);

  @override
  Future<RealtimeBillsResponse> getRealtimeBills({int page = 1}) async {
    final data = await _provider.getRealtimeBills(page: page);
    return RealtimeBillsResponse.fromMap(data);
  }

  @override
  Future<bool> acceptBill({required int billId, required double price}) async {
    return _provider.acceptBill(billId: billId, price: price);
  }
}
