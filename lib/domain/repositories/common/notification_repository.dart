abstract class NotificationRepository {
  Future<Map<String, dynamic>> getNotifications({required int page});
  Future<void> readNotification(String id);
  Future<void> readAllNotifications();
}
