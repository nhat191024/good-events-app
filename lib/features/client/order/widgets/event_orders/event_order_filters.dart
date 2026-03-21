import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';
import '../order_status_badge.dart';

class EventOrderFilters extends StatelessWidget {
  const EventOrderFilters({super.key, required this.controller});

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
              Obx(() {
                final isCurrent = controller.currentEventOrdersTab.value == 0;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isCurrent ? 'orders_label'.tr : 'history_orders_label'.tr,
                      style: context.typography.xl.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isCurrent ? 'current_yours'.tr : 'history_yours'.tr,
                      style: context.typography.xs.copyWith(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                );
              }),

              Row(
                children: [
                  Obx(() {
                    final isCurrent = controller.currentEventOrdersTab.value == 0;
                    final count = isCurrent
                        ? controller.currentEventOrders.length
                        : controller.historyOrders.length;

                    return Container(
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
                          'count': count.toString(),
                        }),
                        style: context.typography.xs.copyWith(
                          color: context.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),

                  const SizedBox(width: 8),

                  Obx(() {
                    final isCurrent = controller.currentEventOrdersTab.value == 0;
                    final isLoading = isCurrent
                        ? controller.isLoadingEventOrders.value
                        : controller.isLoadingHistoryOrders.value;
                    final onRefresh = isCurrent
                        ? controller.fetchEventOrders
                        : controller.fetchHistoryOrders;

                    return GestureDetector(
                      onTap: isLoading ? null : () => onRefresh(),
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[100],
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(
                                Icons.refresh,
                                size: 18,
                                color: Colors.grey[600],
                              ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Status Filter Chips & Sort
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() {
              final isCurrent = controller.currentEventOrdersTab.value == 0;
              return Row(
                children: [
                  // Sort Chip (First Item)
                  GestureDetector(
                    onTap: () => _showSortBottomSheet(context, controller, isCurrent),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.sort, size: 16, color: Colors.grey[700]),
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

                  const SizedBox(width: 8),

                  if (isCurrent) ...[
                    _StatusChip(
                      status: 'pending',
                      isSelected: controller.selectedStatusFilters.contains('pending'),
                      onTap: () => _toggleFilter(controller, 'pending'),
                    ),
                    const SizedBox(width: 8),
                    _StatusChip(
                      status: 'confirmed',
                      isSelected: controller.selectedStatusFilters.contains('confirmed'),
                      onTap: () => _toggleFilter(controller, 'confirmed'),
                    ),
                    const SizedBox(width: 8),
                    _StatusChip(
                      status: 'in_job',
                      isSelected: controller.selectedStatusFilters.contains('in_job'),
                      onTap: () => _toggleFilter(controller, 'in_job'),
                    ),
                  ] else ...[
                    _StatusChip(
                      status: 'completed',
                      isSelected: controller.selectedStatusFilters.contains('completed'),
                      onTap: () => _toggleFilter(controller, 'completed'),
                    ),
                    const SizedBox(width: 8),
                    _StatusChip(
                      status: 'cancelled',
                      isSelected: controller.selectedStatusFilters.contains('cancelled'),
                      onTap: () => _toggleFilter(controller, 'cancelled'),
                    ),
                    const SizedBox(width: 8),
                    _StatusChip(
                      status: 'expired',
                      isSelected: controller.selectedStatusFilters.contains('expired'),
                      onTap: () => _toggleFilter(controller, 'expired'),
                    ),
                  ],
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showSortBottomSheet(
    BuildContext context,
    ClientOrderController controller,
    bool isCurrentTab,
  ) {
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
                'sort_by'.tr,
                style: context.typography.lg.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              if (isCurrentTab) ...[
                _buildSortOption(context, controller, 'upcoming', 'sort_upcoming'),
                _buildSortOption(context, controller, 'most_applicants', 'sort_most_applicants'),
                _buildSortOption(context, controller, 'highest_budget', 'sort_highest_budget'),
                _buildSortOption(context, controller, 'lowest_budget', 'sort_lowest_budget'),
              ] else ...[
                _buildSortOption(context, controller, 'latest_activity', 'sort_latest_activity'),
                _buildSortOption(context, controller, 'newest', 'sort_newest'),
                _buildSortOption(context, controller, 'oldest', 'sort_oldest'),
                _buildSortOption(context, controller, 'highest-budget', 'sort_highest_budget'),
                _buildSortOption(context, controller, 'lowest-budget', 'sort_lowest_budget'),
              ],
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
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  final String status;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final config = OrderStatusConfig.fromStatus(status, context);
    final color = config.textColor;

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
          config.text,
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
