import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/components/button/plus.dart';
import '../../controller.dart';

class AddBankAccountSheet extends StatelessWidget {
  AddBankAccountSheet({super.key, required this.controller});

  final AccountController controller;

  final expireFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final cardNumFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  static Future show(BuildContext context, AccountController controller) {
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
            controller.isCardNameError.value = false;
            controller.isCardNumberError.value = false;
            controller.isCardExpiryError.value = false;
            controller.isCardCvvError.value = false;
          }
        },
        child: AddBankAccountSheet(controller: controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                    child: Text(
                      "add_new_bank".tr,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(color: AppColors.dividers, thickness: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.dividers, width: 1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child: _buildTextField(
                                  context,
                                  'cardholder_name'.tr,
                                  'cardholder_hint'.tr,
                                  TextInputType.text,
                                  controller.cardName,
                                  false,
                                  controller.isCardNameError,
                                ),
                              ),
                              const Divider(color: AppColors.dividers, thickness: 1, height: 1),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child: _buildTextField(
                                  context,
                                  'card_number'.tr,
                                  'card_number_hint'.tr,
                                  TextInputType.number,
                                  controller.cardNumber,
                                  true,
                                  controller.isCardNumberError,
                                ),
                              ),
                              const Divider(color: AppColors.dividers, thickness: 1, height: 1),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
                                      child: _buildTextField(
                                        context,
                                        'expire_date'.tr,
                                        "mm/yy",
                                        TextInputType.datetime,
                                        controller.cardExpiry,
                                        true,
                                        controller.isCardExpiryError,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 67,
                                    child: VerticalDivider(
                                      color: AppColors.dividers,
                                      thickness: 1,
                                      width: 2,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
                                      child: _buildTextField(
                                        context,
                                        'cvv'.tr,
                                        'cvv_hint'.tr,
                                        TextInputType.datetime,
                                        controller.cardCvv,
                                        true,
                                        controller.isCardCvvError,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    controller.saveBankInfo.value = !controller.saveBankInfo.value;
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 40,
                                    height: 25,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: controller.saveBankInfo.value
                                          ? Colors.red
                                          : Colors.grey.withValues(alpha: 0.5),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: AnimatedAlign(
                                      duration: const Duration(milliseconds: 200),
                                      alignment: controller.saveBankInfo.value
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Container(
                                        width: 20,
                                        height: 18,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "save_card".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: context.fTheme.colors.foreground,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomButtonPlus(
                          onTap: () {
                            controller.checkCardInfo();
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
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    String placeholder,
    TextInputType keyboardType,
    TextEditingController controller,
    bool needFormatter,
    RxBool isError,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isError.value
                  ? context.fTheme.colors.error
                  : context.fTheme.colors.mutedForeground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Obx(
          () => TextField(
            keyboardType: keyboardType,
            controller: controller,
            inputFormatters: [
              if (needFormatter) ...[
                if (keyboardType == TextInputType.number) FilteringTextInputFormatter.digitsOnly,
                if (label.toLowerCase().contains('cvv')) LengthLimitingTextInputFormatter(3),
                if (label.toLowerCase().contains('card')) cardNumFormatter,
                if (label.toLowerCase().contains('expire')) expireFormatter,
              ],
            ],
            onChanged: (value) {
              if (value.isNotEmpty) {
                isError.value = false;
              }
            },
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(
                color: isError.value
                    ? context.fTheme.colors.error
                    : context.fTheme.colors.mutedForeground,
              ),
              contentPadding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
              isDense: true,
              border: InputBorder.none,
            ),
            style: TextStyle(color: context.fTheme.colors.mutedForeground, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
