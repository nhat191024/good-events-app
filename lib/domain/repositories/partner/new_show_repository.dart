import 'package:sukientotapp/data/models/partner/partner_bill_model.dart';

abstract class NewShowRepository {
  Future<RealtimeBillsResponse> getRealtimeBills();
}
