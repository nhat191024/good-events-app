import 'package:sukientotapp/core/utils/import/global.dart';
import '../controller/controller.dart';

import 'order_status_badge.dart';

class DetailedInfoSection extends GetView<ClientOrderDetailController> {
  const DetailedInfoSection({super.key});

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
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: Colors.orange[50],
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.image_not_supported, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Obx(
            () => Text(
              controller.isHistory.value ? 'detailed_history_info'.tr : 'detailed_rental_info'.tr,
              style: context.typography.xl.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Obx(
            () => OrderStatusBadge(
              status: controller.status,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              borderRadius: BorderRadius.circular(16),
              upperCaseText: true,
            ),
          ),
          const SizedBox(height: 8),
          Obx(
            () => Text(
              '${'chosen_partner'.tr} \'${controller.parentCategoryName} - ${controller.categoryName}\'',
              style: context.typography.sm.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          Obx(
            () => Column(
              children: [
                _buildInfoRow(context, Icons.calendar_today, 'event_date'.tr, controller.date),
                _buildInfoRow(
                  context,
                  Icons.access_time,
                  'time'.tr,
                  '${controller.startTime} - ${controller.endTime}',
                ),
                _buildInfoRow(context, Icons.location_on, 'location'.tr, controller.address),
                _buildInfoRow(context, Icons.stars, 'event_type'.tr, controller.eventName),
                _buildInfoRow(
                  context,
                  Icons.sticky_note_2,
                  'special_note'.tr,
                  controller.note.isEmpty ? 'none'.tr : controller.note,
                ),
                _buildInfoRow(
                  context,
                  Icons.schedule,
                  'order_creation_time'.tr,
                  controller.createdAt,
                ),
              ],
            ),
          ),

          Obx(
            () => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.handshake, color: Colors.grey[600], size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'chosen_partner'.tr,
                          style: context.typography.xs.copyWith(color: Colors.grey[600]),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.partnerName,
                                style: context.typography.sm.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Icon(Icons.open_in_new, size: 14, color: Colors.grey[600]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Obx(
            () => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.monetization_on, color: Colors.grey[600], size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'sealing_price'.tr,
                          style: context.typography.xs.copyWith(color: Colors.grey[600]),
                        ),
                        Text(
                          '${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(controller.finalTotal)} đ',
                          style: context.typography.lg.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Obx(() {
            if (!controller.isHistory.value && controller.status != 'confirmed') {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'apply_voucher_code'.tr,
                    style: context.typography.xs.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'voucher_placeholder'.tr,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: FTheme.of(context).colors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          'check_and_save_code'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              // Calculate discount difference
              final double discount = controller.total - controller.finalTotal;

              if (discount > 0) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${'discounted'.tr}: ${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(discount)} đ',
                    style: context.typography.sm.copyWith(color: Colors.grey[700]),
                  ),
                );
              }

              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: context.typography.xs.copyWith(color: Colors.grey[600])),
                Text(value, style: context.typography.sm.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
