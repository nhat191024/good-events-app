import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/client/event_order_model.dart';
import 'package:sukientotapp/data/models/client/history_order_model.dart';
import 'package:sukientotapp/data/models/client/asset_order_model.dart';
import 'package:sukientotapp/domain/repositories/client/order_repository.dart';

class ClientOrderController extends GetxController with GetTickerProviderStateMixin {
  final OrderRepository _repository;

  ClientOrderController(this._repository);

  // Parent tab controller (Event Orders | Asset Orders)
  late TabController parentTabController;

  // Child tab controllers
  late TabController eventOrdersTabController; // Current | History
  late TabController assetOrdersTabController; // All | Pending | Paid | Cancelled

  // Refresh controllers
  final RefreshController eventRefreshController = RefreshController(initialRefresh: false);
  final RefreshController historyRefreshController = RefreshController(initialRefresh: false);

  final RefreshController paidAssetRefreshController = RefreshController(initialRefresh: false);
  final RefreshController pendingAssetRefreshController = RefreshController(initialRefresh: false);
  final RefreshController cancelledAssetRefreshController = RefreshController(
    initialRefresh: false,
  );

  final RxInt currentParentTab = 0.obs;
  final RxInt currentEventOrdersTab = 0.obs;

  // Loading states
  final RxBool isLoadingEventOrders = false.obs;
  final RxBool isLoadingHistoryOrders = false.obs;
  final RxBool isLoadingAssetOrders = false.obs;
  final RxBool hasFetchedHistory = false.obs;

  // Data
  final RxList<EventOrderModel> eventOrders = <EventOrderModel>[].obs;
  final RxList<HistoryOrderModel> historyOrders = <HistoryOrderModel>[].obs;
  final RxList<AssetOrderModel> assetOrders = <AssetOrderModel>[].obs;

  // Filters
  final RxString searchQuery = ''.obs;
  final RxString selectedSort = 'upcoming'.obs;
  final RxList<String> selectedStatusFilters = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize parent tabs (2 tabs: Event Orders, Asset Orders)
    parentTabController = TabController(length: 2, vsync: this);

    // Initialize child tabs
    eventOrdersTabController = TabController(length: 2, vsync: this);
    assetOrdersTabController = TabController(length: 3, vsync: this);

    parentTabController.addListener(() {
      if (!parentTabController.indexIsChanging) {
        currentParentTab.value = parentTabController.index;
      }
    });

    // Listen to event orders tab changes (Current / History)
    eventOrdersTabController.addListener(() {
      if (!eventOrdersTabController.indexIsChanging) {
        // Only reset filters if the tab actually changed
        if (currentEventOrdersTab.value != eventOrdersTabController.index) {
          selectedStatusFilters.clear();

          if (eventOrdersTabController.index == 0) {
            selectedSort.value = 'upcoming';
          } else {
            selectedSort.value = 'latest_activity';
          }
        }

        currentEventOrdersTab.value = eventOrdersTabController.index;
        if (eventOrdersTabController.index == 1) {
          if (!hasFetchedHistory.value) {
            fetchHistoryOrders();
          }
        }
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

    eventRefreshController.dispose();
    historyRefreshController.dispose();
    paidAssetRefreshController.dispose();
    pendingAssetRefreshController.dispose();
    cancelledAssetRefreshController.dispose();

    super.onClose();
  }

  final RxInt eventCurrentPage = 1.obs;
  final RxInt eventLastPage = 1.obs;
  final RxBool isFetchingMoreEvent = false.obs;

  // Fetch Event Orders from API
  Future<void> fetchEventOrders({bool force = false, bool loadMore = false}) async {
    if (loadMore) {
      if (isFetchingMoreEvent.value || eventCurrentPage.value >= eventLastPage.value) return;
      isFetchingMoreEvent.value = true;
      eventCurrentPage.value++;
    } else {
      if (isLoadingEventOrders.value) return;
      isLoadingEventOrders.value = true;
      eventCurrentPage.value = 1;
    }

    try {
      final res = await _repository.getEventOrders(page: eventCurrentPage.value);
      if (loadMore) {
        eventOrders.addAll(res.data);
      } else {
        eventOrders.assignAll(res.data);
      }
      eventLastPage.value = res.lastPage;
    } catch (e) {
      logger.e('Failed to fetch event orders: $e');
      if (loadMore) {
        eventCurrentPage.value--; // Revert page increment
      }
    } finally {
      if (loadMore) {
        isFetchingMoreEvent.value = false;
        eventRefreshController.loadComplete();
      } else {
        isLoadingEventOrders.value = false;
        eventRefreshController.refreshCompleted();
      }
    }
  }

  void onRefreshEvent() async {
    await fetchEventOrders();
  }

  void onLoadMoreEvent() async {
    await fetchEventOrders(loadMore: true);
  }

  final RxInt historyCurrentPage = 1.obs;
  final RxInt historyLastPage = 1.obs;
  final RxBool isFetchingMoreHistory = false.obs;

  // Fetch History Orders from API
  Future<void> fetchHistoryOrders({bool force = false, bool loadMore = false}) async {
    if (loadMore) {
      if (isFetchingMoreHistory.value || historyCurrentPage.value >= historyLastPage.value) return;
      isFetchingMoreHistory.value = true;
      historyCurrentPage.value++;
    } else {
      if (isLoadingHistoryOrders.value) return;
      isLoadingHistoryOrders.value = true;
      historyCurrentPage.value = 1;
    }

    try {
      final res = await _repository.getHistoryOrders(page: historyCurrentPage.value);
      if (loadMore) {
        historyOrders.addAll(res.data);
      } else {
        historyOrders.assignAll(res.data);
      }
      historyLastPage.value = res.lastPage;
      hasFetchedHistory.value = true;
    } catch (e) {
      logger.e('Failed to fetch history orders: $e');
      if (loadMore) {
        historyCurrentPage.value--; // Revert page increment
      }
    } finally {
      if (loadMore) {
        isFetchingMoreHistory.value = false;
        historyRefreshController.loadComplete();
      } else {
        isLoadingHistoryOrders.value = false;
        historyRefreshController.refreshCompleted();
      }
    }
  }

  void onRefreshHistory() async {
    await fetchHistoryOrders();
  }

  void onLoadMoreHistory() async {
    await fetchHistoryOrders(loadMore: true);
  }

  // Fetch Asset Orders from API
  Future<void> fetchAssetOrders({RefreshController? refreshController}) async {
    if (isLoadingAssetOrders.value) return;
    isLoadingAssetOrders.value = true;
    try {
      final res = await _repository.getAssetOrders();
      assetOrders.assignAll(res);
    } catch (e) {
      logger.e('Failed to fetch asset orders: $e');
    } finally {
      isLoadingAssetOrders.value = false;
      refreshController?.refreshCompleted();
    }
  }

  void onRefreshAsset(RefreshController refreshController) async {
    await fetchAssetOrders(refreshController: refreshController);
  }

  void onLoadMoreAsset(RefreshController refreshController) async {
    // Currently getAssetOrders doesn't support pagination
    refreshController.loadNoData();
  }

  // Filter logic helper across EventOrder fields
  bool _matchesEventOrderSearch(EventOrderModel order) {
    if (searchQuery.value.trim().isEmpty) return true;
    final q = searchQuery.value.toLowerCase();
    return (order.code).toLowerCase().contains(q) ||
        (order.eventName).toLowerCase().contains(q) ||
        (order.categoryName).toLowerCase().contains(q) ||
        (order.parentCategoryName).toLowerCase().contains(q) ||
        (order.note).toLowerCase().contains(q);
  }

  bool _matchesHistoryOrderSearch(HistoryOrderModel order) {
    if (searchQuery.value.trim().isEmpty) return true;
    final q = searchQuery.value.toLowerCase();
    return (order.code ?? '').toLowerCase().contains(q) ||
        (order.eventName ?? '').toLowerCase().contains(q) ||
        (order.categoryName ?? '').toLowerCase().contains(q) ||
        (order.parentCategoryName ?? '').toLowerCase().contains(q) ||
        (order.note ?? '').toLowerCase().contains(q);
  }

  // Filtered lists
  List<EventOrderModel> get currentEventOrders {
    final filtered = eventOrders.where((order) {
      final isValidCurrentStatus =
          order.status == 'pending' || order.status == 'confirmed' || order.status == 'in_job';

      if (!isValidCurrentStatus) return false;

      if (selectedStatusFilters.isNotEmpty && !selectedStatusFilters.contains(order.status)) {
        return false;
      }

      return _matchesEventOrderSearch(order);
    }).toList();

    // Sorting block
    filtered.sort((a, b) {
      switch (selectedSort.value) {
        case 'upcoming':
          DateTime dateA = DateTime.tryParse('${a.date} ${a.startTime}') ?? DateTime.now();
          DateTime dateB = DateTime.tryParse('${b.date} ${b.startTime}') ?? DateTime.now();
          // Ascending by date, closest event first
          return dateA.compareTo(dateB);
        case 'most_applicants':
          return b.applicantCount.compareTo(a.applicantCount);
        case 'highest_budget':
          return (b.finalTotal ?? 0).compareTo(a.finalTotal ?? 0);
        case 'lowest_budget':
          return (a.finalTotal ?? 0).compareTo(b.finalTotal ?? 0);
        default:
          return 0;
      }
    });

    return filtered;
  }

  List<HistoryOrderModel> get filteredHistoryOrders {
    final filtered = historyOrders.where((order) {
      if (selectedStatusFilters.isNotEmpty && !selectedStatusFilters.contains(order.status)) {
        return false;
      }
      return _matchesHistoryOrderSearch(order);
    }).toList();

    filtered.sort((a, b) {
      switch (selectedSort.value) {
        case 'latest_activity':
          final dateA = DateTime.tryParse(a.updatedAt ?? '') ?? DateTime(0);
          final dateB = DateTime.tryParse(b.updatedAt ?? '') ?? DateTime(0);
          return dateB.compareTo(dateA); // Most recently updated first
        case 'newest':
          final dateA = DateTime.tryParse('${a.date} ${a.startTime}') ?? DateTime(0);
          final dateB = DateTime.tryParse('${b.date} ${b.startTime}') ?? DateTime(0);
          return dateB.compareTo(dateA); // Descending by order date
        case 'oldest':
          final dateA = DateTime.tryParse('${a.date} ${a.startTime}') ?? DateTime(0);
          final dateB = DateTime.tryParse('${b.date} ${b.startTime}') ?? DateTime(0);
          return dateA.compareTo(dateB); // Ascending by order date
        case 'highest-budget':
          return (b.finalTotal ?? 0).compareTo(a.finalTotal ?? 0);
        case 'lowest-budget':
          return (a.finalTotal ?? 0).compareTo(b.finalTotal ?? 0);
        default:
          return 0;
      }
    });

    return filtered;
  }

  List<AssetOrderModel> get allAssetOrders => assetOrders;

  List<AssetOrderModel> get pendingAssetOrders {
    return assetOrders.where((order) => order.status == 'pending').toList();
  }

  List<AssetOrderModel> get paidAssetOrders {
    return assetOrders.where((order) => order.status == 'paid').toList();
  }

  List<AssetOrderModel> get cancelledAssetOrders {
    return assetOrders.where((order) => order.status == 'cancelled').toList();
  }
}
