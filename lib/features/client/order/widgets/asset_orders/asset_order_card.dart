import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:intl/intl.dart';
import '../../controller.dart';

class AssetOrderCard extends StatelessWidget {
  const AssetOrderCard({
    super.key,
    required this.order,
    this.isSelected = false,
  });

  final AssetOrder order;
  final bool isSelected;

  Color _getStatusColor() {
    switch (order.status) {
      case 'pending':
        return const Color(0xFFF59E0B); // Amber
      case 'paid':
        return const Color(0xFF10B981); // Emerald/Green
      case 'cancelled':
        return const Color(0xFFEF4444); // Rose/Red
      default:
        return const Color(0xFF6B7280); // Gray
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    final formattedDate = DateFormat('dd/MM/yyyy').format(order.createdAt);
    final price = order.finalTotal ?? order.total;

    return GestureDetector(
      onTap: () {
        // Handle order detail view
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? context.primary.withValues(alpha: 0.4) : Colors.transparent,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: context.primary.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            if (order.thumbnail != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  order.thumbnail!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.image_outlined,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),

            if (order.thumbnail != null) const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          order.productName,
                          style: context.typography.sm.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: statusColor.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          order.statusLabel,
                          style: context.typography.xs.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '${'category_label'.tr}: ${order.categoryName}',
                    style: context.typography.xs.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${NumberFormat.currency(
                          locale: 'vi_VN',
                          symbol: '',
                          decimalDigits: 0,
                        ).format(price)} đ',
                        style: context.typography.sm.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.primary,
                        ),
                      ),
                      Text(
                        formattedDate,
                        style: context.typography.xs.copyWith(
                          color: Colors.grey[500],
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
    );
  }
}
