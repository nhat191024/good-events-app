import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/domain/repositories/show_repository.dart';

class ShowController extends GetxController with GetSingleTickerProviderStateMixin {
  final ShowRepository _repository;
  ShowController(this._repository);

  final isLoading = false.obs;
  final isSearching = false.obs;

  final searchController = TextEditingController();

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
