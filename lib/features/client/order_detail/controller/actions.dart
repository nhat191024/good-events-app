part of 'controller.dart';

extension ClientOrderDetailActions on ClientOrderDetailController {
  Future<void> fetchOrderDetails({bool showLoading = true}) async {
    if (showLoading) isLoadingDetails.value = true;
    try {
      final results = await Future.wait([
        _repository.getOrderDetails(orderId),
        if (!isHistory.value) _repository.getOrder(orderId),
      ]);

      final details = results[0] as OrderDetailModel?;
      orderDetail.value = details;

      if (!isHistory.value && results.length > 1) {
        final updatedOrder = results[1] as EventOrderModel?;
        if (updatedOrder != null) {
          _eventOrder.value = updatedOrder;

          // Sync back to ClientOrderController if it exists
          if (Get.isRegistered<ClientOrderController>()) {
            final listController = Get.find<ClientOrderController>();
            final index = listController.eventOrders.indexWhere((o) => o.id == updatedOrder.id);
            if (index != -1) {
              listController.eventOrders[index] = updatedOrder;
            }
          }
        }
      }
    } catch (e) {
      logger.e('Error fetching order details: $e');
    } finally {
      if (showLoading) isLoadingDetails.value = false;
    }
  }

  Future<void> choosePartner({
    required int partnerId,
    required double amount,
    required String partnerName,
  }) async {
    final context = Get.context!;
    final confirmed = await Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(24),
          width: Get.width * 0.9,
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'confirm_choose_partner_title'.trParams({'name': partnerName}),
                          style: context.typography.lg.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            style: context.typography.sm.copyWith(color: Colors.black, height: 1.5),
                            children: [
                              TextSpan(
                                text: 'confirm_choose_partner_desc'.tr,
                              ),
                              const TextSpan(text: '\n'),
                              TextSpan(text: 'partner_proposed_price_label'.tr),
                              TextSpan(
                                text:
                                    '${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(amount)} đ',
                                style: const TextStyle(
                                  color: Color(0xFFC62828), // Colors.red[800]
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const TextSpan(text: '\n'),
                              TextSpan(text: 'accept_price_question'.tr),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => Get.back(result: false),
                    child: const Icon(Icons.close, color: Colors.black, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Get.back(result: false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Text('confirm_no_btn'.tr),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => Get.back(result: true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FTheme.of(context).colors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Text(
                      'confirm_yes_btn'.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed != true) return;

    isChoosingPartner.value = true;
    try {
      final result = await _repository.choosePartner(
        orderId: orderId,
        partnerId: partnerId,
      );

      if (result['success'] == true) {
        Get.snackbar('success'.tr, 'choose_partner_success'.tr);
        await fetchOrderDetails();
      } else {
        Get.snackbar(
          'error'.tr,
          result['message'] ?? 'choose_partner_failed'.tr,
          backgroundColor: const Color(0xFFFFEBEE), // Colors.red[50]
          colorText: const Color(0xFFB71C1C), // Colors.red[900]
        );
      }
    } catch (e) {
      logger.e('Error choosing partner: $e');
      Get.snackbar('error'.tr, e.toString());
    } finally {
      isChoosingPartner.value = false;
    }
  }

  Future<void> cancelOrder() async {
    final context = Get.context!;
    final confirmed = await Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(24),
          width: Get.width * 0.9,
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'confirm_cancel_order_title'.tr,
                          style: context.typography.lg.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            style: context.typography.sm.copyWith(color: Colors.black, height: 1.5),
                            children: [
                              TextSpan(
                                text: 'confirm_cancel_order_desc'.tr,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => Get.back(result: false),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: const Icon(Icons.close, color: Colors.black, size: 24),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Get.back(result: false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    ),
                    child: Text('cancel_order_no_btn'.tr),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => Get.back(result: true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FTheme.of(context).colors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    ),
                    child: Text(
                      'cancel_order_yes_btn'.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed != true) return;

    isCancellingOrder.value = true;
    try {
      final result = await _repository.cancelOrder(orderId);

      if (result['success'] == true) {
        Get.snackbar('success'.tr, 'cancel_success'.tr);
        await fetchOrderDetails(); // Refresh to reflect cancelled status
      } else {
        Get.snackbar(
          'error'.tr,
          result['message'] ?? 'cancel_failed'.tr,
          backgroundColor: const Color(0xFFFFEBEE), // Colors.red[50]
          colorText: const Color(0xFFB71C1C), // Colors.red[900]
        );
      }
    } catch (e) {
      logger.e('Error cancelling order: $e');
      Get.snackbar('error'.tr, e.toString());
    } finally {
      isCancellingOrder.value = false;
    }
  }
}
