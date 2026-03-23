import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/partner/wallet_transaction_model.dart';

class TransactionDetailSheet extends StatelessWidget {
  const TransactionDetailSheet({
    super.key,
    required this.transaction,
    required this.formatPrice,
  });

  final WalletTransactionModel transaction;
  final String Function(int) formatPrice;

  static void show(
    BuildContext context,
    WalletTransactionModel transaction,
    String Function(int) formatPrice,
  ) {
    Get.bottomSheet(
      TransactionDetailSheet(
        transaction: transaction,
        formatPrice: formatPrice,
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDebit = transaction.isDebit;
    final Color accentColor = isDebit
        ? AppColors.primary
        : const Color(0xFF10B981);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(),
          _buildAmountHeader(context, isDebit, accentColor),
          _buildDivider(),
          _buildDetails(context, accentColor),
          const SizedBox(height: 24),
          _buildCloseButton(context),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildAmountHeader(
    BuildContext context,
    bool isDebit,
    Color accentColor,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDebit ? FIcons.banknoteArrowUp : FIcons.banknoteArrowDown,
              color: accentColor,
              size: 28,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            isDebit
                ? '-${formatPrice(transaction.amountDouble.toInt())}'
                : '+${formatPrice(transaction.amountDouble.toInt())}',
            style: TextStyle(
              color: accentColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              transaction.type == 'deposit' ? 'deposit'.tr : 'withdrawal'.tr,
              style: TextStyle(
                color: accentColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 1,
      color: Colors.black.withValues(alpha: 0.06),
    );
  }

  Widget _buildDetails(BuildContext context, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Column(
        children: [
          _buildRow(
            context,
            FIcons.info,
            'transaction_id'.tr,
            '#${transaction.id}',
          ),
          _buildRow(
            context,
            FIcons.fileText,
            'reason'.tr,
            transaction.reason,
            multiLine: true,
          ),
          _buildRow(context, FIcons.clock, 'date'.tr, transaction.createdAt),
          _buildBalanceRow(context, accentColor),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    bool multiLine = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: multiLine
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: AppColors.primary, size: 15),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: context.fTheme.colors.mutedForeground,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color: context.fTheme.colors.foreground,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceRow(BuildContext context, Color accentColor) {
    final oldBal = double.tryParse(transaction.oldBalance) ?? 0;
    final newBal = double.tryParse(transaction.newBalance) ?? 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(FIcons.wallet, color: AppColors.primary, size: 15),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'balance_change'.tr,
                  style: TextStyle(
                    color: context.fTheme.colors.mutedForeground,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      formatPrice(oldBal.toInt()),
                      style: TextStyle(
                        color: context.fTheme.colors.mutedForeground,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(
                        FIcons.arrowRight,
                        size: 13,
                        color: context.fTheme.colors.mutedForeground,
                      ),
                    ),
                    Text(
                      formatPrice(newBal.toInt()),
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: Get.back,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: Text(
            'close'.tr,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
