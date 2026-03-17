import 'package:sukientotapp/core/utils/import/global.dart';

/// Notification model for placeholder and UI structure
class NotificationItem {
  final String title;
  final String message;
  final String time;
  final IconData icon;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
  });
}

class NotificationController extends GetxController with GetSingleTickerProviderStateMixin {
  final isLoading = false.obs;
  late TabController tabController;

  // Notification Lists
  final conversations = <NotificationItem>[].obs;
  final orders = <NotificationItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _loadMockData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  /// TODO: API INTEGRATION
  /// 1. Create a NotificationRepository in lib/data/repositories/
  /// 2. Inject it into NotificationBinding
  /// 3. Call repository method here to fetch data
  /// 4. Update the [conversations] and [orders] lists with response data
  Future<void> fetchNotifications() async {
    isLoading.value = true;
    try {
      // Example call:
      // final result = await _repository.getNotifications();
      // conversations.assignAll(result.where((i) => i.type == 'conversation'));
      // orders.assignAll(result.where((i) => i.type == 'order'));
    } catch (e) {
      logger.e("Error fetching notifications: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _loadMockData() {
    // Example conversations items
    conversations.assignAll([
      NotificationItem(
        title: "Dương Công Đạt",
        message: "Chào bạn, mình đã nhận được yêu cầu...",
        time: "10:30 AM",
        icon: Icons.chat_bubble_outline,
      ),
      NotificationItem(
        title: "Tùng Bách",
        message: "Cho mình hỏi về thời gian tổ chức nhé!",
        time: "9:15 AM",
        icon: Icons.chat_bubble_outline,
      ),
    ]);

    // Example orders items
    orders.assignAll([
      NotificationItem(
        title: "Đơn hàng #PB0123",
        message: "Đối tác đã xác nhận đơn hàng của bạn.",
        time: "Hôm qua",
        icon: Icons.assignment_turned_in_outlined,
      ),
      NotificationItem(
        title: "Đơn hàng #PB0124",
        message: "Bạn có 5 ứng viên mới cho sự kiện cưới.",
        time: "2 ngày trước",
        icon: Icons.people_outline,
      ),
    ]);
  }
}
