import 'package:sukientotapp/core/utils/import/global.dart';
import '../controller.dart';

class AssetOrderInfoSection extends GetView<ClientAssetOrderDetailController> {
  const AssetOrderInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: FTheme.of(context).colors.primary.withValues(alpha: 0.2),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'asset_order_details'.tr,
            style: context.typography.base.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildRow(context, Icons.tag, 'order_id'.tr, '#${controller.orderId}'),
          _buildRow(
            context,
            Icons.calendar_today,
            'order_creation_time'.tr,
            controller.formattedCreatedAt,
          ),
          _buildRow(context, Icons.update, 'updated_at_label'.tr, controller.formattedUpdatedAt),
          _buildRow(
            context,
            Icons.payment,
            'payment_method'.tr,
            controller.paymentMethod.replaceAll('_', ' ').toUpperCase(),
          ),
          const Divider(height: 24),
          // Pricing grid
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildPriceRow(
                  context,
                  'design_price'.tr,
                  NumberFormat.currency(
                    locale: 'vi_VN',
                    symbol: '₫',
                    decimalDigits: 0,
                  ).format(controller.total),
                  isBold: false,
                ),
                if (controller.tax != null && controller.tax! > 0) ...[
                  const SizedBox(height: 6),
                  _buildPriceRow(
                    context,
                    'tax'.tr,
                    NumberFormat.currency(
                      locale: 'vi_VN',
                      symbol: '₫',
                      decimalDigits: 0,
                    ).format(controller.tax),
                    isBold: false,
                    color: Colors.grey[600],
                  ),
                ],
                if (controller.finalTotal != null) ...[
                  const Divider(height: 16),
                  _buildPriceRow(
                    context,
                    'final_total'.tr,
                    NumberFormat.currency(
                      locale: 'vi_VN',
                      symbol: '₫',
                      decimalDigits: 0,
                    ).format(controller.finalTotal),
                    isBold: true,
                    color: FTheme.of(context).colors.primary,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[500]),
          const SizedBox(width: 8),
          Text(label, style: context.typography.xs.copyWith(color: Colors.grey[600])),
          const Spacer(),
          Text(
            value,
            style: context.typography.sm.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.typography.sm.copyWith(
            color: color ?? Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: context.typography.sm.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color ?? Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
