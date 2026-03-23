import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/data/models/partner/wallet_transaction_model.dart';
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
  RxInt balance = RxInt(
    (StorageService.readMapData(
              key: LocalStorageKeys.user,
              mapKey: 'wallet_balance',
            )
            as int?) ??
        0,
  );
  final filterDate = DateTime.now().obs;
  final RxInt selectedBank = 0.obs;
  final RxBool isRechargeAmountError = false.obs;
  final TextEditingController rechargeAmount = TextEditingController();
  final RxList<WalletTransactionModel> walletTransactions =
      <WalletTransactionModel>[].obs;
  final RxBool isTransactionsLoading = false.obs;

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
    fetchWalletTransactions();
  }

  void onRefresh() async {
    await fetchWalletTransactions();
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
  Future<void> fetchWalletTransactions() async {
    try {
      isTransactionsLoading.value = true;
      final transactions = await _repository.getWalletTransactions();
      walletTransactions.value = transactions;
    } catch (e) {
      logger.e('[AccountController] fetchWalletTransactions: $e');
      AppSnackbar.showError(title: 'Error', message: e.toString());
    } finally {
      isTransactionsLoading.value = false;
    }
  }

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
      if (StorageService.readData(key: LocalStorageKeys.token) == null) {
        StorageService.clearAllData();
        Get.offAllNamed(Routes.loginScreen);
        return;
      }

      await _repository.logout();
      StorageService.clearAllData();
      Get.offAllNamed(Routes.loginScreen);
    } catch (e) {
      logger.e('[AccountController] [logout] error: $e');
      if (e.toString().contains('unauthorized')) {
        StorageService.clearAllData();
        Get.offAllNamed(Routes.loginScreen);
        return;
      }
      AppSnackbar.showError(title: 'error'.tr, message: 'cannot_logout'.tr);
    } finally {
      isLoading.value = false;
    }
  }
}
