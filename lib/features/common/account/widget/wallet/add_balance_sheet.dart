import 'dart:ui';
import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';

import 'add_bank_account_sheet.dart';

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
                      child: const Icon(FIcons.wallet, color: Colors.white, size: 18),
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
                      Obx(() => Container(
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
                      )),
                      const SizedBox(height: 20),
                      _buildBankSelectBox(context),
                      const SizedBox(height: 16),
                      // Add new bank (outlined button)
                      GestureDetector(
                        onTap: () => AddBankAccountSheet.show(context, controller),
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.black.withValues(alpha: 0.12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FIcons.plus, size: 16, color: context.fTheme.colors.foreground),
                              const SizedBox(width: 8),
                              Text(
                                'add_new_bank'.tr,
                                style: TextStyle(
                                  color: context.fTheme.colors.foreground,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Confirm button (gradient)
                      GestureDetector(
                        onTap: () {
                          // controller.rechargeWallet();
                        },
                        child: Container(
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
                                color: AppColors.primary.withValues(alpha: 0.35),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBankSelectBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "from".tr,
          style: TextStyle(
            color: context.fTheme.colors.foreground,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.bankAccounts.length,
          itemBuilder: (context, index) {
            final bank = controller.bankAccounts[index];
            if (bank['id'] == 1) return SizedBox.shrink();
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
                      // Assuming RadioGroup is defined or available globally.
                      // If not, standard Radio might need groupValue and onChanged which are present in the wrapper in original code.
                      // Replicating the wrapper structure:
                      // Original code had RadioGroup wrapping Radio.
                      // I'll assume RadioGroup is a widget that injects value/onChanged or handles layout.
                      // But standard Radio needs groupValue.
                      // Looking at original code:
                      /*
                       RadioGroup<int>(
                          groupValue: controller.selectedBank.value,
                          onChanged: (value) {
                            controller.selectedBank.value = value!;
                          },
                          child: Radio<int>(
                            value: bank['id'],
                            activeColor: context.fTheme.colors.error,
                          ),
                        ),
                        */
                      // If I get an error about RadioGroup needing to be imported, I'll fix it.
                      // For now I copy it.
                      Transform.scale(
                        scale: 1.3,
                        child: Radio<int>(
                          value: bank['id'],
                          groupValue: controller.selectedBank.value,
                          onChanged: (value) {
                            controller.selectedBank.value = value!;
                          },
                          activeColor: AppColors.primary,
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
