import 'package:sukientotapp/data/models/partner/dashboard_model.dart';
import 'package:sukientotapp/data/providers/partner/dashboard_provider.dart';
import 'package:sukientotapp/domain/repositories/partner/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardProvider _provider;

  DashboardRepositoryImpl(this._provider);

  @override
  Future<DashboardModel> getDashboardData() async {
    final response = await _provider.getDashboardData();
    return DashboardModel.fromMap(response);
  }
}
