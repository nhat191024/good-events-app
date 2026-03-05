import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

// Widgets
import 'widgets/order_header.dart';
import 'widgets/event_orders/event_orders_tab.dart';
import 'widgets/asset_orders/asset_orders_tab.dart';

class ClientOrderScreen extends GetView<ClientOrderController> {
  const ClientOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      childPad: false,
      header: OrderHeader(controller: controller),
      child: TabBarView(
        controller: controller.parentTabController,
        children: [
          EventOrdersTab(controller: controller),
          AssetOrdersTab(controller: controller),
        ],
      ),
    );
  }
}
