import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/client/voucher_model.dart';
import 'package:intl/intl.dart';

class VoucherDetailsBottomSheet extends StatelessWidget {
  final VoucherModel voucher;

  const VoucherDetailsBottomSheet({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'voucher_check_result'.tr,
                          style: context.typography.xs.copyWith(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              voucher.code,
                              style: context.typography.lg.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD1FAE5), // emerald-100
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'available'.tr,
                                style: context.typography.xs.copyWith(
                                  color: const Color(0xFF047857), // emerald-700
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'valid_voucher'.tr,
                          style: context.typography.sm.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.close, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

            // Body Grid
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          title: 'discount_amount'.tr,
                          value: '${voucher.discountPercent}% ${'on_final_price'.tr}',
                          subtitle:
                              '${'maximum'.tr}: ${NumberFormat.currency(locale: 'vi_VN', symbol: 'đ', decimalDigits: 0).format(voucher.maxDiscountAmount)}',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          title: 'min_order_condition'.tr,
                          value:
                              '${NumberFormat.currency(locale: 'vi_VN', symbol: 'đ', decimalDigits: 0).format(voucher.minOrderAmount)}',
                          subtitle: 'voucher_apply_hint'.tr,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          title: 'validity_period'.tr,
                          value: '${'starts_at'.tr}: ${_formatDate(voucher.startsAt)}',
                          subtitle: '${'expires_at_label'.tr}: ${_formatDate(voucher.expiresAt)}',
                          isSubtitleBold: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          title: 'usage_count'.tr,
                          value: voucher.isUnlimited
                              ? 'unlimited_usage'.tr
                              : 'remaining_usage'.trParams({
                                  'count':
                                      (voucher.usageLimit != null
                                              ? voucher.usageLimit! - voucher.timesUsed
                                              : 0)
                                          .toString(),
                                }),
                          subtitle: 'keep_code_hint'.tr,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'voucher_saved_temp'.tr,
                    style: context.typography.xs.copyWith(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
            // Footer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        'close'.tr,
                        style: context.typography.sm.copyWith(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Just close, it's already "saved" in memory
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: FTheme.of(context).colors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        'save_code'.tr,
                        style: context.typography.sm.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    bool isSubtitleBold = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.typography.xs.copyWith(color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(
            value,
            style: context.typography.sm.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: context.typography.xs.copyWith(
              color: isSubtitleBold ? Colors.black87 : Colors.grey[600],
              fontWeight: isSubtitleBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String isoString) {
    if (isoString.isEmpty) return '';
    try {
      final dt = DateTime.parse(isoString);
      return DateFormat('dd/MM/yyyy').format(dt);
    } catch (e) {
      return '';
    }
  }
}
