import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/common/profile_model.dart';
import 'package:sukientotapp/data/models/location_model.dart';
import 'package:sukientotapp/data/providers/location_provider.dart';
import 'package:sukientotapp/domain/repositories/common/my_profile_repository.dart';
import 'package:sukientotapp/features/common/account/controller.dart';
import 'package:sukientotapp/features/partner/home/controller.dart';

import 'controller.dart';

class EditProfileController extends GetxController {
  final MyProfileRepository _repository;
  final LocationProvider _locationProvider;

  EditProfileController(this._repository, this._locationProvider);

  late final ProfileModel initialProfile;

  // Text controllers
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController countryCodeController;
  late final TextEditingController phoneController;
  late final TextEditingController bioController;
  late final TextEditingController partnerNameController;
  late final TextEditingController identityCardController;

  // Image files
  final avatarFile = Rxn<XFile>();
  final selfieFile = Rxn<XFile>();
  final frontCardFile = Rxn<XFile>();
  final backCardFile = Rxn<XFile>();

  // Location
  final provinces = <LocationModel>[].obs;
  final wards = <LocationModel>[].obs;
  final selectedProvince = Rxn<LocationModel>();
  final selectedWard = Rxn<LocationModel>();
  final isLoadingWards = false.obs;
  final isUpdating = false.obs;

  RxString get role => Get.find<MyProfileController>().role;

  @override
  void onInit() {
    super.onInit();
    initialProfile = Get.arguments as ProfileModel;

    nameController = TextEditingController(text: initialProfile.name);
    emailController = TextEditingController(text: initialProfile.email);
    countryCodeController = TextEditingController();
    phoneController = TextEditingController(text: initialProfile.phone);
    bioController = TextEditingController(text: initialProfile.bio);
    partnerNameController = TextEditingController(
      text: initialProfile.partnerName ?? '',
    );
    identityCardController = TextEditingController(
      text: initialProfile.identityCardNumber ?? '',
    );

    if (role.value == 'partner') {
      fetchLocations();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    countryCodeController.dispose();
    phoneController.dispose();
    bioController.dispose();
    partnerNameController.dispose();
    identityCardController.dispose();
    super.onClose();
  }

  Future<void> fetchLocations() async {
    try {
      final data = await _locationProvider.getProvinces();
      final list = data
          .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList();
      provinces.assignAll(list);

      if (initialProfile.locationId != null) {
        final matching = list.where((l) => l.id == initialProfile.locationId);
        if (matching.isNotEmpty) {
          selectedProvince.value = matching.first;
          await fetchWards(matching.first.id);
        }
      }
    } catch (e) {
      logger.e('[EditProfileController] [fetchLocations] error: $e');
    }
  }

  Future<void> fetchWards(int provinceId) async {
    try {
      isLoadingWards.value = true;
      wards.clear();
      selectedWard.value = null;
      final data = await _locationProvider.getWards(provinceId);
      final list = data
          .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList();
      wards.assignAll(list);
    } catch (e) {
      logger.e('[EditProfileController] [fetchWards] error: $e');
    } finally {
      isLoadingWards.value = false;
    }
  }

  void onProvinceChanged(LocationModel province) {
    selectedProvince.value = province;
    fetchWards(province.id);
  }

  Future<void> pickImage(String type) async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;

    switch (type) {
      case 'avatar':
        avatarFile.value = image;
        break;
      case 'selfie':
        selfieFile.value = image;
        break;
      case 'front_card':
        frontCardFile.value = image;
        break;
      case 'back_card':
        backCardFile.value = image;
        break;
    }
  }

  Future<void> updateProfile() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty) {
      AppSnackbar.showError(message: 'name_required'.tr);
      return;
    }
    if (email.isEmpty) {
      AppSnackbar.showError(message: 'email_required'.tr);
      return;
    }

    try {
      isUpdating.value = true;

      final Map<String, dynamic> formDataMap = {
        'name': name,
        'email': email,
        'phone': phoneController.text.trim(),
        'bio': bioController.text.trim(),
      };

      if (role.value == 'partner') {
        formDataMap['partner_name'] = partnerNameController.text.trim();
        formDataMap['identity_card_number'] = identityCardController.text
            .trim();
        if (selectedWard.value != null) {
          formDataMap['location_id'] = selectedWard.value!.id;
        } else if (selectedProvince.value != null) {
          formDataMap['location_id'] = selectedProvince.value!.id;
        }
      }

      if (avatarFile.value != null) {
        formDataMap['avatar'] = await MultipartFile.fromFile(
          avatarFile.value!.path,
          filename: avatarFile.value!.name,
        );
      }

      if (role.value == 'partner') {
        if (selfieFile.value != null) {
          formDataMap['selfie_image'] = await MultipartFile.fromFile(
            selfieFile.value!.path,
            filename: selfieFile.value!.name,
          );
        }
        if (frontCardFile.value != null) {
          formDataMap['front_identity_card_image'] =
              await MultipartFile.fromFile(
                frontCardFile.value!.path,
                filename: frontCardFile.value!.name,
              );
        }
        if (backCardFile.value != null) {
          formDataMap['back_identity_card_image'] =
              await MultipartFile.fromFile(
                backCardFile.value!.path,
                filename: backCardFile.value!.name,
              );
        }
      }

      final formData = FormData.fromMap(formDataMap);
      final updatedProfile = await _repository.updateProfile(formData);

      await Get.find<MyProfileController>().fetchProfile();

      StorageService.updateMapData(
        key: LocalStorageKeys.user,
        mapKey: 'name',
        value: name,
      );

      StorageService.updateMapData(
        key: LocalStorageKeys.user,
        mapKey: 'avatar_url',
        value: updatedProfile.avatarUrl,
      );

      logger.i(
        'Updated avatar in local storage: ${StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'avatar_url')}',
      );

      if (Get.isRegistered<AccountController>()) {
        Get.find<AccountController>().syncFromStorage();
      }

      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().syncFromStorage();
      }

      AppSnackbar.showSuccess(message: 'profile_updated'.tr);
      Get.back();
    } catch (e) {
      logger.e('[EditProfileController] [updateProfile] error: $e');
      AppSnackbar.showError(message: 'update_failed'.tr);
    } finally {
      isUpdating.value = false;
    }
  }
}
