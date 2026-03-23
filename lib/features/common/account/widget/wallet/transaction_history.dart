import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';

class TransactionHistorySection extends StatelessWidget {
  const TransactionHistorySection({super.key, required this.controller});

  final AccountController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(context),
          _buildTransactionList(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  FIcons.arrowLeftRight,
                  color: AppColors.primary,
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "transaction_history".tr,
                style: TextStyle(
                  color: context.fTheme.colors.foreground,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          _buildDateFilterButton(context),
        ],
      ),
    );
  }

  Widget _buildDateFilterButton(BuildContext context) {
    return GestureDetector(
      onTap: _showDatePicker,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Icon(FIcons.calendar, color: AppColors.primary, size: 13),
            const SizedBox(width: 5),
            Obx(
              () => Text(
                DateFormat('MMM yyyy').format(controller.filterDate.value),
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList(BuildContext context) {
    // Use controller.transactionHistories.length when ready
    const int itemCount = 0; // Temporary for testing
    if (itemCount == 0) return _buildEmptyState(context);
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 12),
      itemCount: itemCount,
      separatorBuilder: (_, _) => Divider(
        color: Colors.black.withValues(alpha: 0.06),
        height: 1,
        indent: 20,
        endIndent: 20,
      ),
      itemBuilder: (ctx, index) {
        return null;
        // final transaction = controller.transactionHistories[index];
        // return _buildTransactionItem(ctx, transaction);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(FIcons.receipt, color: AppColors.primary, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            "no_transaction_history".tr,
            style: TextStyle(
              color: context.fTheme.colors.foreground,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Obx(() => Text(
            DateFormat('MMMM yyyy').format(controller.filterDate.value),
            style: TextStyle(
              color: context.fTheme.colors.mutedForeground,
              fontSize: 13,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, dynamic transaction) {
    final bool isDebit = transaction.type == 2;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: isDebit
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : const Color(0xFF10B981).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDebit ? FIcons.banknoteArrowUp : FIcons.banknoteArrowDown,
              color: isDebit ? AppColors.primary : const Color(0xFF10B981),
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: TextStyle(
                    color: context.fTheme.colors.foreground,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.date,
                  style: TextStyle(
                    color: context.fTheme.colors.mutedForeground,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            isDebit
                ? '-${controller.formatPrice(transaction.amount)}'
                : '+${controller.formatPrice(transaction.amount)}',
            style: TextStyle(
              color: isDebit ? AppColors.primary : const Color(0xFF10B981),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: controller.filterDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      controller.filterDate.value = pickedDate;
    }
  }
}
