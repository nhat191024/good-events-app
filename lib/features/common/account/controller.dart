import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/domain/repositories/partner/account_repository.dart';

class AccountController extends GetxController {
  final AccountRepository _repository;
  AccountController(this._repository);

  final isLoading = false.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  //============================================================================
  // PERSONAL INFORMATION
  //============================================================================
  RxString name = (StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'name') ?? '')
      .toString()
      .obs;
  RxString avatar =
      (StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'avatar_url') ?? '')
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
    {'id': 1, 'bank': 'PayOs', 'number': 'Nạp qua mã QR', 'expiry': 'N/A', 'name': 'PayOs'},
  ];

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void onRefresh() async {
    refreshController.refreshCompleted();
  }

  void onLoadMore() async {
    refreshController.loadComplete();
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
}
