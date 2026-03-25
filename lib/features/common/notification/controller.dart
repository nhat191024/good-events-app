import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/common/notification_model.dart';
import 'package:sukientotapp/domain/repositories/common/notification_repository.dart';
import 'package:sukientotapp/domain/repositories/client/order_repository.dart';
import 'package:sukientotapp/features/partner/bottom_navigation/controller.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repository;
  final OrderRepository _orderRepository;

  NotificationController(this._repository, this._orderRepository);

  final isLoading = false.obs;
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  final notifications = <NotificationModel>[].obs;
  int _currentPage = 1;
  int _lastPage = 1;

  bool isServiceProvider = false;

  @override
  void onInit() {
    super.onInit();
    RxString role = (StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'role') ?? '')
        .toString()
        .obs;
    if (role.value == 'partner') {
      isServiceProvider = true;
    }
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

  bool isHistory(String? status) {
    return status == 'completed' || status == 'cancelled';
  }

  Future<void> readNotification(NotificationModel notification) async {
    if (isServiceProvider) {
      await readPartnerNotification(notification);
    } else {
      await readClientNotification(notification);
    }
  }

  Future<void> readPartnerNotification(NotificationModel notification) async {
    // TODO: Partner notification logic will be implemented here
    Get.back();
    Get.find<PartnerBottomNavigationController>().setIndex(1);
    if (!notification.unread) {
      return;
    }

    notification.unread = false;
    notifications.refresh();

    try {
      await _repository.readNotification(notification.id);
    } catch (e) {
      logger.e("Error reading notification: $e");
    }
  }

  Future<void> readClientNotification(NotificationModel notification) async {
    if (notification.orderId != null) {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      try {
        var order = await _orderRepository.getOrder(notification.orderId!);
        bool isHistory = false;
        dynamic targetOrder = order;

        if (order == null) {
          targetOrder = await _orderRepository.getHistoryOrder(notification.orderId!);
          isHistory = true;
        }

        if (Get.isDialogOpen ?? false) Get.back();

        if (targetOrder != null) {
          Get.toNamed(
            Routes.clientOrderDetail,
            arguments: {'order': targetOrder, 'isHistory': isHistory},
          );
        }
      } catch (e) {
        if (Get.isDialogOpen ?? false) Get.back();
        logger.e("Error fetching order details: $e");
      }
    }
    if (!notification.unread) {
      return;
    }

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
