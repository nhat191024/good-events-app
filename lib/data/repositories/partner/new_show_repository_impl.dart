import 'package:sukientotapp/data/models/partner/partner_bill_model.dart';
import 'package:sukientotapp/data/providers/partner/new_show_provider.dart';
import 'package:sukientotapp/domain/repositories/partner/new_show_repository.dart';

class NewShowRepositoryImpl implements NewShowRepository {
  final NewShowProvider _provider;

  NewShowRepositoryImpl(this._provider);

  @override
  Future<RealtimeBillsResponse> getRealtimeBills() async {
    final data = await _provider.getRealtimeBills();
    return RealtimeBillsResponse.fromMap(data);
  }
}
