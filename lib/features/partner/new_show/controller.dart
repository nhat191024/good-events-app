import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/domain/repositories/partner/new_show_repository.dart';

class NewShowController extends GetxController {
  //TODO: Fetch data from repository for new show
  final NewShowRepository _repository;
  NewShowController(this._repository);
  

  final isLoading = false.obs;

  // Pagination logic
  final ScrollController scrollController = ScrollController();
  final items = <int>[].obs;
  final isLoadMore = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize demo data
    items.addAll(List.generate(5, (index) => index));
    scrollController.addListener(_onScroll);
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

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}