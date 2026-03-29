import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/repositories/partner/account_repository.dart';
import 'package:sukientotapp/features/partner/home/controller.dart';

import '../account/controller.dart';

enum PaymentStatus { paid, pending, processing, cancelled }

class PaymentResultController extends GetxController {
  final AccountRepository _repository;
  PaymentResultController(this._repository);

  late final bool cancel;
  late final PaymentStatus status;
  late final int orderCode;

  final RxBool isConfirming = true.obs;
  final RxInt newBalance = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _parseRouteParameters();
    if (isPaid) {
      _confirmPayment();
    } else {
      isConfirming.value = false;
    }
  }

  Future<void> _confirmPayment() async {
    try {
      final result = await _repository.confirmAddFunds(
        orderCode: orderCode.toString(),
        status: 'PAID',
      );
      final balance = result['new_balance'];
      if (balance != null) {
        newBalance.value = (balance as num).toInt();
        // Persist updated balance locally so AccountController reflects it
        StorageService.updateMapData(
          key: LocalStorageKeys.user,
          mapKey: 'wallet_balance',
          value: newBalance.value,
        );

        if (Get.isRegistered<AccountController>()) {
          Get.find<AccountController>().syncBalance();
        }

        if (Get.isRegistered<PartnerHomeController>()) {
          Get.find<PartnerHomeController>().syncBalance();
        }
      }
    } catch (e) {
      logger.e('[PaymentResultController] [_confirmPayment] error: \$e');
    } finally {
      isConfirming.value = false;
    }
  }

  void _parseRouteParameters() {
    final params = Get.parameters;
    cancel = (params['cancel'] ?? 'false').toLowerCase() == 'true';
    orderCode = int.tryParse(params['orderCode'] ?? '0') ?? 0;

    if (cancel) {
      status = PaymentStatus.cancelled;
    } else {
      status = _parseStatus(params['status'] ?? '');
    }

    logger.d(
      'Parsed PaymentResultController parameters: cancel=$cancel, status=$status, orderCode=$orderCode',
    );
  }

  PaymentStatus _parseStatus(String raw) {
    switch (raw.toUpperCase()) {
      case 'PAID':
        return PaymentStatus.paid;
      case 'PENDING':
        return PaymentStatus.pending;
      case 'PROCESSING':
        return PaymentStatus.processing;
      case 'CANCELLED':
      default:
        return PaymentStatus.cancelled;
    }
  }

  bool get isPaid => status == PaymentStatus.paid;
  bool get isPending => status == PaymentStatus.pending;
  bool get isProcessing => status == PaymentStatus.processing;
  bool get isCancelled => status == PaymentStatus.cancelled;

  void goToHome() {
    Get.until(
      (route) =>
          route.settings.name == Routes.clientHome ||
          route.settings.name == Routes.partnerHome,
    );
  }
}
