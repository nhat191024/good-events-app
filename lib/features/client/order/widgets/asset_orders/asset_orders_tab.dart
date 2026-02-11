import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';
import 'asset_order_list.dart';

class AssetOrdersTab extends StatelessWidget {
  const AssetOrdersTab({super.key, required this.controller});

  final ClientOrderController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Child TabBar
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: TabBar(
            controller: controller.assetOrdersTabController,
            labelColor: context.primary,
            unselectedLabelColor: Colors.black54,
            labelStyle: context.typography.sm.copyWith(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: context.typography.xs,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.grey.withValues(alpha: 0.2),
            isScrollable: true,
            tabs: [
              Tab(text: 'paid_status'.tr),
              Tab(text: 'pending_status'.tr),
              Tab(text: 'cancelled_status'.tr),
            ],
          ),
        ),

        // Child TabBarView
        Expanded(
          child: TabBarView(
            controller: controller.assetOrdersTabController,
            children: [
              // Paid Orders
              Obx(
                () => AssetOrderList(
                  controller: controller,
                  orders: controller.paidAssetOrders,
                  emptyMessage: 'no_paid_asset_orders'.tr,
                ),
              ),

              // Pending Orders
              Obx(
                () => AssetOrderList(
                  controller: controller,
                  orders: controller.pendingAssetOrders,
                  emptyMessage: 'no_pending_asset_orders'.tr,
                ),
              ),

              // Cancelled Orders
              Obx(
                () => AssetOrderList(
                  controller: controller,
                  orders: controller.cancelledAssetOrders,
                  emptyMessage: 'no_cancelled_asset_orders'.tr,
                ),
              ),

              SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}
