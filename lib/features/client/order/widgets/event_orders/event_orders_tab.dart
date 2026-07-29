import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';
import 'event_order_filters.dart';
import 'current_orders_tab.dart';
import 'history_orders_tab.dart';

class EventOrdersTab extends StatelessWidget {
  const EventOrdersTab({
    super.key,
    required this.controller,
    required this.tabController,
  });

  final ClientOrderController controller;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filters Section
        EventOrderFilters(controller: controller),

        // Child TabBar
        Container(
          color: Colors.white,
          child: TabBar(
            controller: tabController,
            labelColor: context.primary,
            unselectedLabelColor: Colors.black54,
            labelStyle: context.typography.sm.copyWith(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: context.typography.sm,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.grey.withValues(alpha: 0.2),
            tabs: [
              Tab(text: 'current_orders'.tr),
              Tab(text: 'history'.tr),
            ],
          ),
        ),

        // Child TabBarView
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              CurrentOrdersTab(controller: controller),
              HistoryOrdersTab(controller: controller),
            ],
          ),
        ),

        SizedBox(height: 50),
      ],
    );
  }
}
