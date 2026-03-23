import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';

// import 'add_bank_account_sheet.dart';

class _CurrencyInputFormatter extends TextInputFormatter {
  final _fmt = NumberFormat('#,###', 'vi_VN');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return newValue.copyWith(text: '');
    final number = int.parse(digits);
    final formatted = _fmt.format(number).replaceAll(',', '.');
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  static double? parse(String formatted) {
    final digits = formatted.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return null;
    return double.tryParse(digits);
  }
}

class AddBalanceSheet extends StatelessWidget {
  const AddBalanceSheet({
    super.key,
    required this.controller,
    required this.label,
  });

  final AccountController controller;
  final String label;

  static Future show(
    BuildContext context,
    AccountController controller,
    String label,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withValues(alpha: 0.1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) => PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) {
            // controller.withdrawAmount.clear();
            // controller.selectedBank.value = 0;
          }
        },
        child: AddBalanceSheet(controller: controller, label: label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 6),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.primary.withValues(alpha: 0.75),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          FIcons.wallet,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: context.fTheme.colors.foreground,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black.withValues(alpha: 0.07), height: 1),
                // Body
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'enter_amount'.tr,
                          style: TextStyle(
                            color: context.fTheme.colors.foreground,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: controller.isRechargeAmountError.value
                                    ? context.fTheme.colors.error
                                    : Colors.transparent,
                              ),
                            ),
                            child: TextField(
                              controller: controller.rechargeAmount,
                              keyboardType: TextInputType.number,
                              inputFormatters: [_CurrencyInputFormatter()],
                              style: TextStyle(
                                color: context.fTheme.colors.foreground,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                hintText: 'enter'.tr,
                                hintStyle: TextStyle(
                                  color: context.fTheme.colors.mutedForeground,
                                  fontWeight: FontWeight.normal,
                                ),
                                prefixIcon: Icon(
                                  FIcons.banknote,
                                  color: controller.isRechargeAmountError.value
                                      ? context.fTheme.colors.error
                                      : AppColors.primary,
                                  size: 18,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildBankSelectBox(context),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            controller.rechargeWallet();
                          },
                          child: Obx(
                            () => Container(
                              width: double.infinity,
                              height: 52,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primary.withValues(alpha: 0.75),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.35,
                                    ),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: controller.isRechargeLoading.value
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : Text(
                                        'add'.tr,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBankSelectBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "from".tr,
              style: TextStyle(
                color: context.fTheme.colors.foreground,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () => {
                AppSnackbar.showInfo(
                  title: 'info'.tr,
                  message: 'add_bank_not_supported'.tr,
                ),

                // Get.back(),
                // Future.delayed(const Duration(microseconds: 300)),
                // AddBankAccountSheet.show(context, controller),
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FIcons.plus,
                      size: 13,
                      color: context.fTheme.colors.foreground,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'add_source'.tr,
                      style: TextStyle(
                        color: context.fTheme.colors.foreground,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.bankAccounts.length,
          itemBuilder: (context, index) {
            final bank = controller.bankAccounts[index];
            return Obx(
              () => GestureDetector(
                onTap: () {
                  controller.selectedBank.value = bank['id'];
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    color: controller.selectedBank.value == bank['id']
                        ? AppColors.primary.withValues(alpha: 0.08)
                        : Colors.transparent,
                    border: Border.all(
                      color: controller.selectedBank.value == bank['id']
                          ? AppColors.primary
                          : Colors.black.withValues(alpha: 0.1),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bank['bank'],
                            style: TextStyle(
                              color: context.fTheme.colors.mutedForeground,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            bank['number'],
                            style: TextStyle(
                              color: context.fTheme.colors.mutedForeground,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Transform.scale(
                        scale: 1.3,
                        child: RadioGroup<int>(
                          groupValue: controller.selectedBank.value,
                          onChanged: (value) {
                            controller.selectedBank.value = value!;
                          },
                          child: Radio<int>(
                            value: bank['id'],
                            activeColor: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
