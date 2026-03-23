import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/domain/api_url.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:sukientotapp/domain/repositories/partner/account_repository.dart';

class AccountController extends GetxController {
  final AccountRepository _repository;
  AccountController(this._repository);

  final isLoading = false.obs;
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  //============================================================================
  // PERSONAL INFORMATION
  //============================================================================
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

  RxString role =
      (StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'role') ??
              '')
          .toString()
          .obs;
  final RxBool saveBankInfo = false.obs;

  //============================================================================
  // WALLET & TRANSACTIONS
  //============================================================================
  final RxInt balance = 100000.obs;
  final filterDate = DateTime.now().obs;
  final RxInt selectedBank = 0.obs;
  final RxBool isRechargeAmountError = false.obs;
  final TextEditingController rechargeAmount = TextEditingController();

  //============================================================================
  // CARD INFORMATION
  //============================================================================
  final TextEditingController cardName = TextEditingController();
  final RxBool isCardNameError = false.obs;
  final TextEditingController cardNumber = TextEditingController();
  final RxBool isCardNumberError = false.obs;
  final TextEditingController cardExpiry = TextEditingController();
  final RxBool isCardExpiryError = false.obs;
  final TextEditingController cardCvv = TextEditingController();
  final RxBool isCardCvvError = false.obs;

  final List<Map<String, dynamic>> bankAccounts = [
    {
      'id': 1,
      'bank': 'PayOs',
      'number': 'Nạp qua mã QR',
      'expiry': 'N/A',
      'name': 'PayOs',
    },
  ];

  @override
  void onInit() {
    super.onInit();

    logger.d(
      '[AccountController] avatar: ${avatar.value}, name: ${name.value}, role: ${role.value}',
    );
  }

  void onRefresh() async {
    refreshController.refreshCompleted();
  }

  void onLoadMore() async {
    refreshController.loadComplete();
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

  //============================================================================
  // CARD VALIDATION METHODS
  //============================================================================
  void checkCardInfo() {
    _validateCardName();
    _validateCardNumber();
    _validateCardExpiry();
    _validateCardCvv();
  }

  void _validateCardName() {
    isCardNameError.value = cardName.text.isEmpty;
  }

  void _validateCardNumber() {
    isCardNumberError.value = cardNumber.text.isEmpty;
  }

  void _validateCardExpiry() {
    isCardExpiryError.value = cardExpiry.text.isEmpty;
  }

  void _validateCardCvv() {
    isCardCvvError.value = cardCvv.text.isEmpty;
  }

  //============================================================================
  // HELPER METHODS
  //============================================================================
  void filterTransactionsByDate(DateTime date) {
    filterDate.value = date;
    // Add logic to filter transactions by date
  }

  String formatPrice(int price) {
    final formatted = NumberFormat('#,##0', 'en_US').format(price);
    return '$formatted ${"currency".tr}';
  }

  //============================================================================
  // AUTHENTICATION
  //============================================================================
  Future<void> logout() async {
    isLoading.value = true;
    try {
      if (!Get.isRegistered<ApiService>()) {
        Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
      }

      if (StorageService.readData(key: LocalStorageKeys.token) == null) {
        StorageService.clearAllData();
        Get.offAllNamed(Routes.loginScreen);
        return;
      }

      final api = Get.find<ApiService>();

      final response = await api.dio.get(AppUrl.logout);

      if (response.statusCode == 200) {
        StorageService.clearAllData();
        Get.offAllNamed(Routes.loginScreen);
      } else {
        AppSnackbar.showError(
          title: 'error'.tr,
          message: 'logout_failed'.tr,
        );
      }
    } on DioException catch (e) {
      logger.e('[AccountController] [logout] DioException: ${e.message}');
      if (e.response?.statusCode == 401) {
        StorageService.clearAllData();
        Get.offAllNamed(Routes.loginScreen);
        return;
      }
      AppSnackbar.showError(
        title: 'error'.tr,
        message: 'cannot_logout'.tr,
      );
    } catch (e) {
      logger.e('[AccountController] [logout] Unknown error: $e');
      AppSnackbar.showError(
        title: 'error'.tr,
        message: 'logout_unknown_error'.tr,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
