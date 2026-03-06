import 'package:sukientotapp/data/models/partner/dashboard_model.dart';

abstract class DashboardRepository {
  Future<DashboardModel> getDashboardData();
}
