import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';

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
            // Wallet icon
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(color: context.primary.withValues(alpha: 0.4)),
              ),
              child: Icon(FIcons.wallet, color: context.primary, size: 28),
            ),
            const SizedBox(height: 20),
            Text(
              'no_transaction_history'.tr,
              style: TextStyle(
                color: context.fTheme.colors.foreground,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${"no_balance_description_1".tr} ${controller.formatPrice(controller.balance.value)}\n${"no_balance_description_2".tr}",
              style: TextStyle(
                color: context.fTheme.colors.secondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
