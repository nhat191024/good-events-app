import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';

class EventOrderFilters extends StatelessWidget {
  const EventOrderFilters({
    super.key,
    required this.controller,
  });

  final ClientOrderController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Column(
        children: [
          // Header Row: Order Count and Refresh
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'orders_label'.tr,
                    style: context.typography.xl.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'current_yours'.tr,
                    style: context.typography.xs.copyWith(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: context.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: context.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        'orders_count'.trParams({
                          'count': controller.eventOrders.length.toString(),
                        }),
                        style: context.typography.xs.copyWith(
                          color: context.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Obx(
                    () => GestureDetector(
                      onTap: controller.isLoadingEventOrders.value
                          ? null
                          : controller.fetchEventOrders,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[100],
                        ),
                        child: controller.isLoadingEventOrders.value
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Icon(
                                Icons.refresh,
                                size: 18,
                                color: Colors.grey[600],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Status Filter Chips & Sort
          Obx(
            () => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                // Sort Chip (First Item)
                GestureDetector(
                  onTap: () => _showSortBottomSheet(context, controller),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sort,
                          size: 16,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'sort_${controller.selectedSort.value}'.tr,
                          style: context.typography.xs.copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                _StatusChip(
                  label: 'status_pending'.tr,
                  value: 'pending',
                  color: const Color(0xFFF59E0B),
                  isSelected: controller.selectedStatusFilters.contains('pending'),
                  onTap: () => _toggleFilter(controller, 'pending'),
                ),
                _StatusChip(
                  label: 'status_confirmed'.tr,
                  value: 'confirmed',
                  color: const Color(0xFF3B82F6),
                  isSelected: controller.selectedStatusFilters.contains('confirmed'),
                  onTap: () => _toggleFilter(controller, 'confirmed'),
                ),
                _StatusChip(
                  label: 'status_in_job'.tr,
                  value: 'in_job',
                  color: const Color(0xFF10B981),
                  isSelected: controller.selectedStatusFilters.contains('in_job'),
                  onTap: () => _toggleFilter(controller, 'in_job'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSortBottomSheet(BuildContext context, ClientOrderController controller) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'sort_by'.tr, // Make sure this key exists or use a hardcoded string/general key
                style: context.typography.lg.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildSortOption(context, controller, 'newest', 'sort_newest'),
              _buildSortOption(context, controller, 'oldest', 'sort_oldest'),
              _buildSortOption(context, controller, 'highest_budget', 'sort_highest_budget'),
              _buildSortOption(context, controller, 'lowest_budget', 'sort_lowest_budget'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(
    BuildContext context,
    ClientOrderController controller,
    String value,
    String labelKey,
  ) {
    return ListTile(
      title: Text(
        labelKey.tr,
        style: context.typography.base.copyWith(
          fontWeight: controller.selectedSort.value == value ? FontWeight.bold : FontWeight.normal,
          color: controller.selectedSort.value == value ? context.primary : Colors.black87,
        ),
      ),
      trailing: controller.selectedSort.value == value
          ? Icon(Icons.check, color: context.primary)
          : null,
      onTap: () {
        controller.selectedSort.value = value;
        Navigator.pop(context);
      },
    );
  }

  void _toggleFilter(ClientOrderController controller, String filter) {
    if (controller.selectedStatusFilters.contains(filter)) {
      controller.selectedStatusFilters.remove(filter);
    } else {
      controller.selectedStatusFilters.add(filter);
    }
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.value,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String value;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: isSelected ? 0.15 : 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: isSelected ? 0.3 : 0.1),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: context.typography.xs.copyWith(
            color: color,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
