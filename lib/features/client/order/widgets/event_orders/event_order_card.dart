import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:intl/intl.dart';
import '../../controller.dart';

class EventOrderCard extends StatelessWidget {
  const EventOrderCard({
    super.key,
    required this.order,
    this.isSelected = false,
  });

  final EventOrder order;
  final bool isSelected;

  Color _getStatusColor() {
    switch (order.status) {
      case 'pending':
        return const Color(0xFFF59E0B); // Amber
      case 'confirmed':
        return const Color(0xFF3B82F6); // Blue
      case 'in_job':
        return const Color(0xFF10B981); // Green
      case 'completed':
        return const Color(0xFF10B981); // Green
      case 'cancelled':
        return const Color(0xFFEF4444); // Red
      default:
        return const Color(0xFF6B7280); // Gray
    }
  }

  String _getStatusText() {
    switch (order.status) {
      case 'pending':
        return 'status_pending'.tr;
      case 'confirmed':
        return 'status_confirmed'.tr;
      case 'in_job':
        return 'status_in_job'.tr;
      case 'completed':
        return 'status_completed'.tr;
      case 'cancelled':
        return 'status_cancelled'.tr;
      default:
        return order.status;
    }
  }

  String _getVietnameseDayOfWeek(DateTime date) {
    final isVietnamese = Get.locale?.languageCode == 'vi';
    final days = isVietnamese
        ? ['Chủ nhật', 'Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy']
        : ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    return days[date.weekday % 7];
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    // Simple date formatting without locale-specific data
    final formattedDate = DateFormat('dd/MM/yyyy').format(order.eventDate);
    final dayOfWeek = _getVietnameseDayOfWeek(order.eventDate);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: isSelected ? context.primary : statusColor,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar and Chat Button Column
                Column(
                  children: [
                    // Partner Avatar
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.primary.withValues(alpha: 0.1),
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          order.partnerAvatar,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: context.primary.withValues(alpha: 0.1),
                            child: Icon(
                              Icons.person,
                              color: context.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Chat Button
                    Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        color: context.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: context.primary.withValues(alpha: 0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 12),

                // Order Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Partner Name
                      Text(
                        order.partnerName,
                        style: context.typography.base.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Location
                      Text(
                        'at_location'.trParams({'address': order.address}),
                        style: context.typography.xs.copyWith(
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      // Note
                      if (order.note.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '${'note_label'.tr}: ${order.note}',
                            style: context.typography.xs.copyWith(
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                      const SizedBox(height: 8),

                      // Event Date and Time
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 12,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'event_at'.trParams({
                                'day': dayOfWeek,
                                'date': formattedDate,
                                'start': order.startTime,
                                'end': order.endTime,
                              }),
                              style: context.typography.xs.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Price and Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${'final_price'.tr}: ${NumberFormat.currency(
                              locale: 'vi_VN',
                              symbol: '',
                              decimalDigits: 0,
                            ).format(order.finalPrice)} đ',
                            style: context.typography.xs.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.primary,
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: statusColor.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Text(
                              _getStatusText(),
                              style: context.typography.xs.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // "Viewing" Badge
          if (isSelected)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: context.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'viewing'.tr.toUpperCase(),
                  style: context.typography.xs.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
