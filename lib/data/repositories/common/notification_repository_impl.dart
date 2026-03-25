import 'package:sukientotapp/data/models/common/notification_model.dart';
import 'package:sukientotapp/data/providers/common/notification_provider.dart';
import 'package:sukientotapp/domain/repositories/common/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationProvider _provider;

  NotificationRepositoryImpl(this._provider);

  @override
  Future<Map<String, dynamic>> getNotifications({required int page}) async {
    final response = await _provider.getNotifications(page: page);
    final data = response['data'] as List;
    final notifications = data.map((e) => NotificationModel.fromJson(e)).toList();
    
    return {
      'data': notifications,
      'meta': response['meta'],
    };
  }

  @override
  Future<void> readNotification(String id) async {
    await _provider.readNotification(id);
  }

  @override
  Future<void> readAllNotifications() async {
    await _provider.readAllNotifications();
  }
}
