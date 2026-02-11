import 'package:sukientotapp/core/utils/import/global.dart';
import '../controller.dart';
import 'wallet/wallet_bottom_sheet.dart';

class WalletHeader extends StatelessWidget {
  const WalletHeader({super.key, required this.controller});

  final AccountController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_buildHeaderContainer(context), _buildHeaderContent(context)]);
  }

  Widget _buildHeaderContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: Get.height,
      decoration: BoxDecoration(
        color: context.fTheme.colors.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
    );
  }

  Widget _buildHeaderContent(BuildContext context) {
    return Positioned(
      top: 30,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildWalletIcon(context),
            _buildBalanceInfo(),
            const Spacer(),
            _buildExpandButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletIcon(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      padding: const EdgeInsets.all(12),
      child: Icon(FIcons.wallet, color: context.fTheme.colors.primary, size: 28),
    );
  }

  Widget _buildBalanceInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
          controller.formatPrice(controller.balance.value),
          style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildExpandButton(BuildContext context) {
    return IconButton(
      onPressed: () => WalletBottomSheet.show(context, controller),
      icon: const Icon(Icons.arrow_forward_sharp, color: AppColors.white),
    );
  }
}
