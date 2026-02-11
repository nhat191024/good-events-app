import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/components/button/plus.dart';
import '../../controller.dart';
import 'add_balance_sheet.dart';

class WalletEmptyState extends StatelessWidget {
  const WalletEmptyState({super.key, required this.controller});

  final AccountController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Icon(FIcons.wallet, color: AppColors.white, size: 64),
            const SizedBox(height: 20),
            // if (controller.balance.value > 0)
            Text(
              'no_transaction_history'.tr,
              style: TextStyle(
                color: context.fTheme.colors.foreground,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // else
            //   Text(
            //     'no_balance'.tr,
            //     style: const TextStyle(
            //       color: AppColors.primaryText,
            //       fontSize: 20,
            //       fontFamily: AppFontStyleTextStrings.bold,
            //     ),
            //   ),
            const SizedBox(height: 10),
            Text(
              "${"no_balance_description_1".tr} ${controller.formatPrice(controller.balance.value)}\n${"no_balance_description_2".tr}",
              style: TextStyle(color: context.fTheme.colors.secondary, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomButtonPlus(
              onTap: () => AddBalanceSheet.show(context, controller, 'add_balance'.tr),
              icon: FIcons.plus,
              btnText: "add_balance".tr,
              fontWeight: FontWeight.w600,
              textSize: 14,
              width: Get.width * 0.4,
              borderColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
