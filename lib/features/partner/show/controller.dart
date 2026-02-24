import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/domain/repositories/partner/show_repository.dart';

class ShowController extends GetxController with GetSingleTickerProviderStateMixin {
  final ShowRepository _repository;
  ShowController(this._repository);

  final isLoading = false.obs;
  final isSearching = false.obs;

  final searchController = TextEditingController();

  late TabController tabController;

  // Pagination logic for NewWidget
  final ScrollController scrollController = ScrollController();
  final items = <int>[].obs;
  final isLoadMore = false.obs;

  // Pagination logic for UpcomingWidget
  final ScrollController upcomingScrollController = ScrollController();
  final upcomingItems = <int>[].obs;
  final isUpcomingLoadMore = false.obs;

  // Pagination logic for HistoryWidget
  final ScrollController historyScrollController = ScrollController();
  final historyItems = <int>[].obs;
  final isHistoryLoadMore = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);

    // Initialize demo data
    items.addAll(List.generate(5, (index) => index));
    scrollController.addListener(_onScroll);

    upcomingItems.addAll(List.generate(5, (index) => index));
    upcomingScrollController.addListener(_onUpcomingScroll);

    historyItems.addAll(List.generate(5, (index) => index));
    historyScrollController.addListener(_onHistoryScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 &&
        !isLoadMore.value) {
      loadMore();
    }
  }

  Future<void> loadMore() async {
    isLoadMore.value = true;
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    items.addAll(List.generate(5, (index) => items.length + index));
    isLoadMore.value = false;
  }

  void _onUpcomingScroll() {
    if (upcomingScrollController.position.pixels >=
            upcomingScrollController.position.maxScrollExtent - 200 &&
        !isUpcomingLoadMore.value) {
      loadMoreUpcoming();
    }
  }

  Future<void> loadMoreUpcoming() async {
    isUpcomingLoadMore.value = true;
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    upcomingItems.addAll(List.generate(5, (index) => upcomingItems.length + index));
    isUpcomingLoadMore.value = false;
  }

  void _onHistoryScroll() {
    if (historyScrollController.position.pixels >=
            historyScrollController.position.maxScrollExtent - 200 &&
        !isHistoryLoadMore.value) {
      loadMoreHistory();
    }
  }

  Future<void> loadMoreHistory() async {
    isHistoryLoadMore.value = true;
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    historyItems.addAll(List.generate(5, (index) => historyItems.length + index));
    isHistoryLoadMore.value = false;
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
