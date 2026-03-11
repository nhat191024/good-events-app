import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/partner/partner_bill_model.dart';
import 'package:sukientotapp/domain/repositories/partner/new_show_repository.dart';

class NewShowController extends GetxController {
  final NewShowRepository _repository;
  NewShowController(this._repository);

  final isLoading = false.obs;
  final ScrollController scrollController = ScrollController();

  final bills = <PartnerBill>[].obs;
  final availableCategories = <AvailableCategory>[].obs;
  final lastUpdated = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRealtimeBills();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoading.value) {
      fetchRealtimeBills();
    }
  }

  Future<void> fetchRealtimeBills() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      final response = await _repository.getRealtimeBills();
      bills.assignAll(response.partnerBills);
      availableCategories.assignAll(response.availableCategories);
      lastUpdated.value = response.lastUpdated;
      logger.i('[NewShow] [Fetch] Fetched ${bills.length} bills');
    } catch (e) {
      logger.e('[NewShow] [Fetch] Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
