import 'package:sukientotapp/core/utils/import/global.dart';

// Mock Data Models
class EventOrder {
  final int id;
  final String code;
  final String partnerName;
  final String partnerAvatar;
  final String eventType;
  final String location;
  final String address;
  final DateTime eventDate;
  final String startTime;
  final String endTime;
  final String note;
  final double finalPrice;
  final String status; // pending, confirmed, in_job, completed, cancelled
  final DateTime createdAt;

  EventOrder({
    required this.id,
    required this.code,
    required this.partnerName,
    required this.partnerAvatar,
    required this.eventType,
    required this.location,
    required this.address,
    required this.eventDate,
    required this.startTime,
    required this.endTime,
    required this.note,
    required this.finalPrice,
    required this.status,
    required this.createdAt,
  });
}

class AssetOrder {
  final int id;
  final String productName;
  final String categoryName;
  final double total;
  final double? finalTotal;
  final String status; // pending, paid, cancelled
  final String statusLabel;
  final DateTime createdAt;
  final String? thumbnail;

  AssetOrder({
    required this.id,
    required this.productName,
    required this.categoryName,
    required this.total,
    this.finalTotal,
    required this.status,
    required this.statusLabel,
    required this.createdAt,
    this.thumbnail,
  });
}

class ClientOrderController extends GetxController with GetTickerProviderStateMixin {
  // Parent tab controller (Event Orders | Asset Orders)
  late TabController parentTabController;

  // Child tab controllers
  late TabController eventOrdersTabController; // Current | History
  late TabController assetOrdersTabController; // All | Pending | Paid | Cancelled

  final RxInt currentParentTab = 0.obs;

  // Loading states
  final RxBool isLoadingEventOrders = false.obs;
  final RxBool isLoadingAssetOrders = false.obs;

  // Data
  final RxList<EventOrder> eventOrders = <EventOrder>[].obs;
  final RxList<AssetOrder> assetOrders = <AssetOrder>[].obs;

  // Filters
  final RxString searchQuery = ''.obs;
  final RxString selectedSort = 'newest'.obs;
  final RxList<String> selectedStatusFilters = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize parent tabs (2 tabs: Event Orders, Asset Orders)
    parentTabController = TabController(length: 2, vsync: this);

    // Initialize child tabs
    eventOrdersTabController = TabController(length: 2, vsync: this); // Current, History
    assetOrdersTabController = TabController(
      length: 3,
      vsync: this,
    ); // Paid, Pending, Cancelled

    // Listen to parent tab changes
    parentTabController.addListener(() {
      if (!parentTabController.indexIsChanging) {
        currentParentTab.value = parentTabController.index;
      }
    });

    // Load initial data
    fetchEventOrders();
    fetchAssetOrders();
  }

  @override
  void onClose() {
    parentTabController.dispose();
    eventOrdersTabController.dispose();
    assetOrdersTabController.dispose();
    super.onClose();
  }

  // Mock API call for Event Orders
  Future<void> fetchEventOrders() async {
    isLoadingEventOrders.value = true;

    await Future.delayed(const Duration(seconds: 2));

    eventOrders.value = [
      EventOrder(
        id: 1001,
        code: 'EV001',
        partnerName: 'van bong',
        partnerAvatar: 'https://i.pravatar.cc/150?img=1',
        eventType: 'Tiệc cưới',
        location: 'Bắc Ninh',
        address: 'asdsadadsadssdad, Phường Chũ, Bắc Ninh',
        eventDate: DateTime(2026, 1, 31),
        startTime: '01:00',
        endTime: '04:00',
        note: 'asdsadsad',
        finalPrice: 999999,
        status: 'confirmed',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      EventOrder(
        id: 1002,
        code: 'EV002',
        partnerName: 'MC Hùng',
        partnerAvatar: 'https://i.pravatar.cc/150?img=2',
        eventType: 'Hội nghị',
        location: 'Hà Nội',
        address: '123 Đường Láng, Đống Đa, Hà Nội',
        eventDate: DateTime.now().add(const Duration(days: 5)),
        startTime: '09:00',
        endTime: '17:00',
        note: 'Cần âm thanh chất lượng cao',
        finalPrice: 5000000,
        status: 'pending',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      EventOrder(
        id: 1003,
        code: 'EV003',
        partnerName: 'DJ Sound Pro',
        partnerAvatar: 'https://i.pravatar.cc/150?img=3',
        eventType: 'Sinh nhật',
        location: 'TP. Hồ Chí Minh',
        address: '456 Nguyễn Huệ, Quận 1, TP.HCM',
        eventDate: DateTime.now().add(const Duration(days: 2)),
        startTime: '18:00',
        endTime: '22:00',
        note: 'Pool party theme',
        finalPrice: 3500000,
        status: 'in_job',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      EventOrder(
        id: 1004,
        code: 'EV004',
        partnerName: 'Decor Events',
        partnerAvatar: 'https://i.pravatar.cc/150?img=4',
        eventType: 'Khai trương',
        location: 'Đà Nẵng',
        address: '789 Trần Phú, Hải Châu, Đà Nẵng',
        eventDate: DateTime.now().subtract(const Duration(days: 10)),
        startTime: '08:00',
        endTime: '12:00',
        note: 'Trang trí hoa tươi màu đỏ vàng',
        finalPrice: 12000000,
        status: 'completed',
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
    ];

    isLoadingEventOrders.value = false;
  }

  // Mock API call for Asset Orders
  Future<void> fetchAssetOrders() async {
    isLoadingAssetOrders.value = true;

    await Future.delayed(const Duration(milliseconds: 1500));

    assetOrders.value = [
      AssetOrder(
        id: 2001,
        productName: 'Template thiết kế backdrop tiệc cưới',
        categoryName: 'Thiết kế backdrop',
        total: 299000,
        finalTotal: 249000,
        status: 'paid',
        statusLabel: 'Đã thanh toán',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        thumbnail: 'https://picsum.photos/200/200?random=1',
      ),
      AssetOrder(
        id: 2002,
        productName: 'Bộ thiết kế menu nhà hàng cao cấp',
        categoryName: 'Thiết kế menu',
        total: 199000,
        status: 'pending',
        statusLabel: 'Chờ xử lý',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        thumbnail: 'https://picsum.photos/200/200?random=2',
      ),
      AssetOrder(
        id: 2003,
        productName: 'Template thiệp mời sinh nhật trẻ em',
        categoryName: 'Thiệp mời',
        total: 150000,
        finalTotal: 120000,
        status: 'paid',
        statusLabel: 'Đã thanh toán',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        thumbnail: 'https://picsum.photos/200/200?random=3',
      ),
      AssetOrder(
        id: 2004,
        productName: 'Bộ icons social media cho sự kiện',
        categoryName: 'Icons & Graphics',
        total: 99000,
        status: 'cancelled',
        statusLabel: 'Đã hủy',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        thumbnail: 'https://picsum.photos/200/200?random=4',
      ),
    ];

    isLoadingAssetOrders.value = false;
  }

  // Filtered lists
  List<EventOrder> get currentEventOrders {
    return eventOrders.where((order) {
      return order.status == 'pending' || order.status == 'confirmed' || order.status == 'in_job';
    }).toList();
  }

  List<EventOrder> get historyEventOrders {
    return eventOrders.where((order) {
      return order.status == 'completed' || order.status == 'cancelled';
    }).toList();
  }

  List<AssetOrder> get allAssetOrders => assetOrders;

  List<AssetOrder> get pendingAssetOrders {
    return assetOrders.where((order) => order.status == 'pending').toList();
  }

  List<AssetOrder> get paidAssetOrders {
    return assetOrders.where((order) => order.status == 'paid').toList();
  }

  List<AssetOrder> get cancelledAssetOrders {
    return assetOrders.where((order) => order.status == 'cancelled').toList();
  }
}
