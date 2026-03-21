import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/common/profile_model.dart';
import 'package:sukientotapp/domain/repositories/common/my_profile_repository.dart';

class MyProfileController extends GetxController {
  final MyProfileRepository _repository;
  MyProfileController(this._repository);

  final isLoading = true.obs;
  final Rxn<ProfileModel> profile = Rxn<ProfileModel>();

  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  //============================================================================
  // PERSONAL INFORMATION
  //============================================================================
  RxString role =
      (StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'role') ??
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
    fetchProfile();
  }

  void onRefresh() async {
    refreshController.refreshCompleted();
  }

  void onLoadMore() async {
    refreshController.loadComplete();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final data = await _repository.getProfile();
      profile.value = data;
    } catch (e) {
      logger.e('[MyProfileController] [fetchProfile] error: $e');
      AppSnackbar.showError(message: 'failed_to_load_profile'.tr);
    } finally {
      isLoading.value = false;
    }
  }
}
