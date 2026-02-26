import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';

class TransactionHistorySection extends StatelessWidget {
  const TransactionHistorySection({super.key, required this.controller});

  final AccountController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTransactionHistoryHeader(context),
        // const DashedDivider(color: AppColors.dividers, height: 2),
        _buildTransactionList(),
      ],
    );
  }

  Widget _buildTransactionHistoryHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "transaction_history".tr,
            style: TextStyle(
              color: context.fTheme.colors.foreground,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
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
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
          color: context.fTheme.colors.background,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: Row(
          children: [
            Icon(FIcons.calendar, color: context.fTheme.colors.foreground, size: 14),
            const SizedBox(width: 5),
            Obx(
              () => Text(
                DateFormat('MMMM yyyy').format(controller.filterDate.value),
                style: TextStyle(
                  color: context.fTheme.colors.foreground,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // itemCount: controller.transactionHistories.length,
      itemCount: 1, // Temporary for testing
      itemBuilder: (context, index) {
        return null;

        // final transaction = controller.transactionHistories[index];
        // return _buildTransactionItem(transaction);
      },
    );
  }

  Widget _buildTransactionItem(BuildContext context, dynamic transaction) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: transaction.type == 2 ? AppColors.red50 : AppColors.infoLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              transaction.type == 2 ? FIcons.banknoteArrowUp : FIcons.banknoteArrowDown,
              color: transaction.type == 2 ? AppColors.primary : AppColors.infoMain,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.description,
                style: TextStyle(
                  color: context.fTheme.colors.foreground,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                transaction.type == 2
                    ? '-${controller.formatPrice(transaction.amount)}'
                    : '+${controller.formatPrice(transaction.amount)}',
                style: TextStyle(
                  color: transaction.type == 2 ? AppColors.primary : AppColors.infoMain,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            transaction.date,
            style: TextStyle(
              color: context.fTheme.colors.mutedForeground,
              fontSize: 13,
              fontWeight: FontWeight.normal,
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
