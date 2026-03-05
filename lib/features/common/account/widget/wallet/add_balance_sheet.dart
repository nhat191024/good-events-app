import 'dart:ui';
import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';
import 'package:sukientotapp/features/components/button/plus.dart';
import 'package:sukientotapp/features/components/text/customTextField.dart';
import 'add_bank_account_sheet.dart';

class AddBalanceSheet extends StatelessWidget {
  const AddBalanceSheet({super.key, required this.controller, required this.label});

  final AccountController controller;
  final String label;

  static Future show(BuildContext context, AccountController controller, String label) {
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
        child: FractionallySizedBox(
          heightFactor: 1.2,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(color: AppColors.dividers, thickness: 1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Column(
                    children: [
                      CustomTextField(
                        labelText: 'enter_amount'.tr,
                        hintText: 'enter'.tr,
                        errorText: "",
                        isError: controller.isRechargeAmountError,
                        obscureText: false.obs,
                        keyboardType: TextInputType.number,
                        controller: controller.rechargeAmount,
                        onChanged: (value) {},
                        rightPadding: 0,
                        leftPadding: 0,
                        isRequire: false,
                      ),
                      const SizedBox(height: 15),
                      _buildBankSelectBox(context),
                      CustomButtonPlus(
                        onTap: () {
                          AddBankAccountSheet.show(context, controller);
                        },
                        btnText: 'add_new_bank'.tr,
                        color: AppColors.white,
                        textColor: context.fTheme.colors.foreground,
                        borderColor: context.fTheme.colors.border,
                        borderRadius: 16,
                        height: 55,
                        topPadding: 20,
                        bottomPadding: 0,
                        leftPadding: 0,
                        rightPadding: 0,
                        width: double.infinity,
                      ),
                      CustomButtonPlus(
                        onTap: () {
                          // controller.rechargeWallet();
                        },
                        btnText: "add".tr,
                        color: context.fTheme.colors.foreground,
                        textColor: AppColors.white,
                        height: 55,
                        topPadding: 20,
                        bottomPadding: 0,
                        leftPadding: 0,
                        rightPadding: 0,
                        width: double.infinity,
                      ),
                    ],
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
                        ? AppColors.red100
                        : Colors.transparent,
                    border: Border.all(
                      color: controller.selectedBank.value == bank['id']
                          ? context.fTheme.colors.error
                          : AppColors.dividers,
                      width: 1,
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
                          activeColor: context.fTheme.colors.error,
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
