import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

// Widgets
import 'widgets/order_header.dart';
import 'widgets/event_orders/event_orders_tab.dart';
import 'widgets/asset_orders/asset_orders_tab.dart';

class ClientOrderScreen extends StatefulWidget {
  const ClientOrderScreen({super.key});

  @override
  State<ClientOrderScreen> createState() => _ClientOrderScreenState();
}

class _ClientOrderScreenState extends State<ClientOrderScreen>
    with TickerProviderStateMixin {
  late final ClientOrderController controller;
  late final TabController parentTabController;
  late final TabController eventOrdersTabController;
  late final TabController assetOrdersTabController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ClientOrderController>();
    parentTabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: controller.currentParentTab.value,
    );
    eventOrdersTabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: controller.currentEventOrdersTab.value,
    );
    assetOrdersTabController = TabController(length: 3, vsync: this);

    parentTabController.addListener(_onParentTabChanged);
    eventOrdersTabController.addListener(_onEventOrdersTabChanged);
  }

  void _onParentTabChanged() {
    if (!parentTabController.indexIsChanging) {
      controller.onParentTabChanged(parentTabController.index);
    }
  }

  void _onEventOrdersTabChanged() {
    if (!eventOrdersTabController.indexIsChanging) {
      controller.onEventOrdersTabChanged(eventOrdersTabController.index);
    }
  }

  @override
  void dispose() {
    parentTabController.removeListener(_onParentTabChanged);
    eventOrdersTabController.removeListener(_onEventOrdersTabChanged);
    parentTabController.dispose();
    eventOrdersTabController.dispose();
    assetOrdersTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      childPad: false,
      header: OrderHeader(
        controller: controller,
        tabController: parentTabController,
      ),
      child: TabBarView(
        controller: parentTabController,
        children: [
          EventOrdersTab(
            controller: controller,
            tabController: eventOrdersTabController,
          ),
          AssetOrdersTab(
            controller: controller,
            tabController: assetOrdersTabController,
          ),
        ],
      ),
    );
  }
}
