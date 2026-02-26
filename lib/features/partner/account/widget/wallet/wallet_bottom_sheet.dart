import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/components/button/plus.dart';
import '../../controller.dart';
import 'wallet_empty_state.dart';
import 'add_balance_sheet.dart';

class WalletBottomSheet extends StatelessWidget {
  const WalletBottomSheet({super.key, required this.controller});

  final AccountController controller;

  static void show(BuildContext context, AccountController controller) {
    Get.bottomSheet(WalletBottomSheet(controller: controller), isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildBottomSheetBackground(context),
        _buildBottomSheetHeader(context),
        _buildBottomSheetBody(context),
        _buildCloseButton(),
      ],
    );
  }

  Widget _buildBottomSheetBackground(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.fTheme.colors.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
    );
  }

  Widget _buildBottomSheetHeader(BuildContext context) {
    return Positioned(
      top: Get.height * 0.1,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'my_balance_wallet'.tr,
              style: TextStyle(
                color: AppColors.white.withValues(alpha: 0.7),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              controller.formatPrice(100000),
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            CustomButtonPlus(
              onTap: () => AddBalanceSheet.show(context, controller, ''.tr),
              btnText: "add_balance".tr,
              color: AppColors.white,
              textColor: context.fTheme.colors.foreground,
              width: Get.width * 0.75,
              height: 44,
              topPadding: 20,
              leftPadding: 0,
              rightPadding: 5,
              borderColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: Get.width,
            margin: EdgeInsets.only(top: Get.height * 0.27),
            decoration: const BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
                child:
                    // Obx(() {
                    // if (controller.transactionHistories.isEmpty) {
                    WalletEmptyState(controller: controller),
                // }
                // return TransactionHistorySection(controller: controller);/
                // }),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCloseButton() {
    return Align(
      alignment: Alignment.topCenter,
      child: Transform.translate(
        offset: const Offset(0, 45),
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
            child: const Icon(Icons.close, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
