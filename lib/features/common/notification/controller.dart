import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/common/notification_model.dart';
import 'package:sukientotapp/domain/repositories/common/notification_repository.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repository;

  NotificationController(this._repository);

  final isLoading = false.obs;
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  final notifications = <NotificationModel>[].obs;
  int _currentPage = 1;
  int _lastPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications(isRefresh: true);
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<void> fetchNotifications({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
    } else {
      if (_currentPage >= _lastPage) {
        refreshController.loadNoData();
        return;
      }
      _currentPage++;
    }

    if (notifications.isEmpty) {
      isLoading.value = true;
    }

    try {
      final result = await _repository.getNotifications(page: _currentPage);
      final List<NotificationModel> newItems = result['data'] as List<NotificationModel>;
      final meta = result['meta'] as Map<String, dynamic>?;

      if (meta != null) {
        _lastPage = meta['last_page'] as int? ?? 1;
      }

      if (isRefresh) {
        notifications.assignAll(newItems);
        refreshController.refreshCompleted();
        refreshController.resetNoData();
      } else {
        notifications.addAll(newItems);
        if (_currentPage >= _lastPage) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      }
    } catch (e) {
      logger.e("Error fetching notifications: $e");
      if (isRefresh) {
        refreshController.refreshFailed();
      } else {
        refreshController.loadFailed();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> readNotification(NotificationModel notification) async {
    if (!notification.unread) return;

    // Optimistic UI update
    notification.unread = false;
    notifications.refresh();

    try {
      await _repository.readNotification(notification.id);
    } catch (e) {
      // Ignoring errors
      logger.e("Error reading notification: $e");
    }
  }

  Future<void> readAll() async {
    // Optimistic UI update
    bool changed = false;
    for (var n in notifications) {
      if (n.unread) {
        n.unread = false;
        changed = true;
      }
    }
    if (changed) notifications.refresh();

    try {
      await _repository.readAllNotifications();
    } catch (e) {
      // Ignoring errors
      logger.e("Error reading all notifications: $e");
    }
  }
}
