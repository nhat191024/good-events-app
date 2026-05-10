import 'package:sukientotapp/data/providers/common/report_provider.dart';
import 'package:sukientotapp/domain/repositories/common/report_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportProvider _provider;

  ReportRepositoryImpl(this._provider);

  @override
  Future<Map<String, dynamic>> reportBill({
    required int reportedBillId,
    required String title,
    required String description,
  }) {
    return _provider.reportBill(
      reportedBillId: reportedBillId,
      title: title,
      description: description,
    );
  }

  @override
  Future<Map<String, dynamic>> reportUser({
    required int reportedUserId,
    required String title,
    required String description,
  }) {
    return _provider.reportUser(
      reportedUserId: reportedUserId,
      title: title,
      description: description,
    );
  }
}
