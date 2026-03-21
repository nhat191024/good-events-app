import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/client/asset_order_model.dart';
import '../../controller.dart';
import 'asset_order_card.dart';

class AssetOrderList extends StatelessWidget {
  const AssetOrderList({
    super.key,
    required this.controller,
    required this.orders,
    required this.emptyMessage,
    required this.refreshController,
    required this.onRefresh,
    required this.onLoading,
  });

  final ClientOrderController controller;
  final List<AssetOrderModel> orders;
  final String emptyMessage;
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: false,
      header: const ClassicHeader(),
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: _getItemCount(),
      itemBuilder: (context, index) {
        if (controller.isLoadingAssetOrders.value) {
          return _buildLoadingItem(context, index);
        }

        if (orders.isEmpty) {
          return _buildEmptyItem(context);
        }

        if (index == 0) {
          return _buildHeader(context);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AssetOrderCard(
            order: orders[index - 1],
            isSelected: (index - 1) == 0,
          ),
        );
      },
    );
  }

  int _getItemCount() {
    if (controller.isLoadingAssetOrders.value) return 3;
    if (orders.isEmpty) return 1;
    return orders.length + 1; // Header + List
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'purchased_designs'.tr,
            style: context.typography.base.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: context.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${orders.length}',
              style: context.typography.xs.copyWith(
                color: context.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingItem(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      height: 100,
      decoration: BoxDecoration(
        color: context.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.primary.withValues(alpha: 0.1),
          style: BorderStyle.solid,
        ),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildEmptyItem(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey[200]!,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Text(
                emptyMessage,
                style: context.typography.sm.copyWith(color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
