import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/repositories/client/home_repository.dart';

import 'package:sukientotapp/data/models/client/home_summary_model.dart';
import 'package:sukientotapp/data/models/client/blog_home_model.dart';
import 'package:sukientotapp/data/models/client/partner_category_model.dart';

class ClientHomeController extends GetxController {
  final HomeRepository _repository;
  ClientHomeController(this._repository);

  // States
  final Rx<HomeSummaryModel?> summary = Rx<HomeSummaryModel?>(null);
  final RxList<BlogItemModel> blogs = <BlogItemModel>[].obs;
  final RxList<PartnerCategoryModel> partnerList = <PartnerCategoryModel>[].obs;

  // Loaders
  final isLoadingSummary = false.obs;
  final isLoadingBlogs = false.obs;
  final isLoadingPartners = false.obs;

  // User data
  RxString name =
      (StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'name') ??
              '')
          .toString()
          .obs;

  RxString avatar =
      (StorageService.readMapData(
                key: LocalStorageKeys.user,
                mapKey: 'avatar_url',
              ) ??
              '')
          .toString()
          .obs;

  @override
  void onInit() {
    super.onInit();
    syncFromStorage();
    // Load all data on mount
    fetchSummary();
    fetchBlogs();
    fetchPartners();
  }

  void syncFromStorage() {
    name.value =
        (StorageService.readMapData(
                  key: LocalStorageKeys.user,
                  mapKey: 'name',
                ) ??
                '')
            .toString();
    avatar.value =
        (StorageService.readMapData(
                  key: LocalStorageKeys.user,
                  mapKey: 'avatar_url',
                ) ??
                '')
            .toString();
  }

  Future<void> fetchSummary() async {
    if (isLoadingSummary.value) return;
    isLoadingSummary.value = true;
    try {
      summary.value = await _repository.getHomeSummary();
    } catch (e) {
      logger.e('Failed to fetch home summary: $e');
    } finally {
      isLoadingSummary.value = false;
    }
  }

  Future<void> fetchBlogs() async {
    if (isLoadingBlogs.value) return;
    isLoadingBlogs.value = true;
    try {
      final res = await _repository.getHomeBlogs();
      blogs.assignAll(res);
    } catch (e) {
      logger.e('Failed to fetch home blogs: $e');
    } finally {
      isLoadingBlogs.value = false;
    }
  }

  Future<void> fetchPartners({bool force = false}) async {
    if (isLoadingPartners.value) return;
    if (!force && partnerList.isNotEmpty) return;

    isLoadingPartners.value = true;
    try {
      final res = await _repository.getPartnerCategories();
      partnerList.assignAll(res);
    } catch (e) {
      logger.e('Failed to fetch partner categories: $e');
    } finally {
      isLoadingPartners.value = false;
    }
  }

  void ensurePartnersLoaded() {
    if (partnerList.isEmpty && !isLoadingPartners.value) {
      fetchPartners();
    }
  }

  void openBrowser(String url) async {
    /// will implement later (url_launcher lib)
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
