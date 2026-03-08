import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/repositories/client/home_repository.dart';

class PartnerDetailController extends GetxController {
  final HomeRepository _repository;
  PartnerDetailController(this._repository);

  final RxString partnerSlug = ''.obs;

  // UI States mapped from API Model
  final RxString partnerId = ''.obs;
  final RxString partnerName = ''.obs;
  final RxString partnerImage = ''.obs;
  final RxString category = ''.obs;
  final RxString subCategory = ''.obs;
  final RxString serviceType = ''.obs;
  final RxString priceRange = ''.obs;
  final RxString updateTime = ''.obs;
  final RxString description = ''.obs;

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final args = Get.arguments as Map<String, dynamic>;
      partnerSlug.value = args['slug'] ?? '';
    }

    if (partnerSlug.value.isNotEmpty) {
      fetchPartnerDetails(partnerSlug.value);
    } else {
      isLoading.value = false;
      Get.snackbar('error'.tr, 'invalid_arguments'.tr);
    }
  }

  Future<void> fetchPartnerDetails(String slug) async {
    isLoading.value = true;
    try {
      final detail = await _repository.getPartnerCategoryDetail(slug);

      // Update UI observables
      partnerId.value = detail.item.id.toString();
      partnerName.value = detail.item.name;
      partnerImage.value = detail.item.image;
      category.value = detail.category.name;
      subCategory.value = detail.item.name; // Based on fake data structure
      serviceType.value = detail.item.name;

      // Format prices
      final minP = _formatPrice(detail.item.minPrice);
      final maxP = _formatPrice(detail.item.maxPrice);
      priceRange.value = '$minP đ - $maxP đ';

      updateTime.value = detail.item.updatedHuman;
      description.value = detail.item.description;
    } catch (e) {
      logger.e('Failed to fetch partner details for $slug: $e');
      Get.snackbar('error'.tr, 'fetch_failed'.tr);
    } finally {
      isLoading.value = false;
    }
  }

  String _formatPrice(int price) {
    // Simple 3-digit comma formatting helper for UI
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}
