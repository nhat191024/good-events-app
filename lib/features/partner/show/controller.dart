import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/partner/show_bill_model.dart';
import 'package:sukientotapp/domain/repositories/partner/show_repository.dart';

class ShowController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ShowRepository _repository;
  ShowController(this._repository);

  final isLoading = false.obs;
  final isSearching = false.obs;

  final searchController = TextEditingController();

  late TabController tabController;

  // --- New tab (status: pending) ---
  final ScrollController scrollController = ScrollController();
  final newBills = <ShowBill>[].obs;
  final isLoadMore = false.obs;
  int _newPage = 1;
  int _newLastPage = 1;

  // --- Upcoming tab (status: confirmed) ---
  final ScrollController upcomingScrollController = ScrollController();
  final upcomingBills = <ShowBill>[].obs;
  final isUpcomingLoading = false.obs;
  final isUpcomingLoadMore = false.obs;
  int _upcomingPage = 1;
  int _upcomingLastPage = 1;

  // --- History tab (status: history) ---
  final ScrollController historyScrollController = ScrollController();
  final historyBills = <ShowBill>[].obs;
  final isHistoryLoading = false.obs;
  final isHistoryLoadMore = false.obs;
  int _historyPage = 1;
  int _historyLastPage = 1;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    _fetchNewBills(reset: true);
    _fetchUpcomingBills(reset: true);
    _fetchHistoryBills(reset: true);

    scrollController.addListener(_onScroll);
    upcomingScrollController.addListener(_onUpcomingScroll);
    historyScrollController.addListener(_onHistoryScroll);
  }

  void switchTab(int index) {
    tabController.animateTo(index);
  }

  // ─── New Tab ────────────────────────────────────────────────────────────────

  Future<void> _fetchNewBills({bool reset = false}) async {
    if (reset) {
      _newPage = 1;
      _newLastPage = 1;
      newBills.clear();
      isLoading.value = true;
    }
    try {
      final response = await _repository.getBills(
        status: 'pending',
        page: _newPage,
      );
      _newLastPage = response.meta.lastPage;
      newBills.addAll(response.bills);
    } catch (e) {
      Get.snackbar('error'.tr, 'load_data_failed'.tr);
    } finally {
      isLoading.value = false;
    }
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoadMore.value &&
        _newPage < _newLastPage) {
      loadMore();
    }
  }

  Future<void> loadMore() async {
    isLoadMore.value = true;
    _newPage++;
    try {
      final response = await _repository.getBills(
        status: 'pending',
        page: _newPage,
      );
      _newLastPage = response.meta.lastPage;
      newBills.addAll(response.bills);
    } catch (e) {
      _newPage--;
    } finally {
      isLoadMore.value = false;
    }
  }

  // ─── Upcoming Tab ────────────────────────────────────────────────────────────

  Future<void> _fetchUpcomingBills({bool reset = false}) async {
    if (reset) {
      _upcomingPage = 1;
      _upcomingLastPage = 1;
      upcomingBills.clear();
      isUpcomingLoading.value = true;
    }
    try {
      final response = await _repository.getBills(
        status: 'confirmed',
        page: _upcomingPage,
      );
      _upcomingLastPage = response.meta.lastPage;
      upcomingBills.addAll(response.bills);
    } catch (e) {
      Get.snackbar('error'.tr, 'load_data_failed'.tr);
    } finally {
      isUpcomingLoading.value = false;
    }
  }

  void _onUpcomingScroll() {
    if (upcomingScrollController.position.pixels >=
            upcomingScrollController.position.maxScrollExtent - 200 &&
        !isUpcomingLoadMore.value &&
        _upcomingPage < _upcomingLastPage) {
      loadMoreUpcoming();
    }
  }

  Future<void> loadMoreUpcoming() async {
    isUpcomingLoadMore.value = true;
    _upcomingPage++;
    try {
      final response = await _repository.getBills(
        status: 'confirmed',
        page: _upcomingPage,
      );
      _upcomingLastPage = response.meta.lastPage;
      upcomingBills.addAll(response.bills);
    } catch (e) {
      _upcomingPage--;
    } finally {
      isUpcomingLoadMore.value = false;
    }
  }

  // ─── History Tab ─────────────────────────────────────────────────────────────

  Future<void> _fetchHistoryBills({bool reset = false}) async {
    if (reset) {
      _historyPage = 1;
      _historyLastPage = 1;
      historyBills.clear();
      isHistoryLoading.value = true;
    }
    try {
      final response = await _repository.getBills(
        status: 'history',
        page: _historyPage,
      );
      _historyLastPage = response.meta.lastPage;
      historyBills.addAll(response.bills);
    } catch (e) {
      Get.snackbar('error'.tr, 'load_data_failed'.tr);
    } finally {
      isHistoryLoading.value = false;
    }
  }

  void _onHistoryScroll() {
    if (historyScrollController.position.pixels >=
            historyScrollController.position.maxScrollExtent - 200 &&
        !isHistoryLoadMore.value &&
        _historyPage < _historyLastPage) {
      loadMoreHistory();
    }
  }

  Future<void> loadMoreHistory() async {
    isHistoryLoadMore.value = true;
    _historyPage++;
    try {
      final response = await _repository.getBills(
        status: 'history',
        page: _historyPage,
      );
      _historyLastPage = response.meta.lastPage;
      historyBills.addAll(response.bills);
    } catch (e) {
      _historyPage--;
    } finally {
      isHistoryLoadMore.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    upcomingScrollController.dispose();
    historyScrollController.dispose();
    tabController.dispose();
    searchController.dispose();
    super.onClose();
  }
}

