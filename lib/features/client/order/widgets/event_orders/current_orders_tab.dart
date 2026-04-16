import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';
import 'event_order_card.dart';

class CurrentOrdersTab extends StatefulWidget {
  const CurrentOrdersTab({super.key, required this.controller});

  final ClientOrderController controller;

  @override
  State<CurrentOrdersTab> createState() => _CurrentOrdersTabState();
}

class _CurrentOrdersTabState extends State<CurrentOrdersTab> {
  late final RefreshController refreshController;

  ClientOrderController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingEventOrders.value && controller.eventOrders.isEmpty) {
        return _buildLoading();
      }

      final orders = controller.currentEventOrders;

      if (orders.isEmpty) {
        return _buildEmpty(context);
      }

      return SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        enablePullUp: true,
        header: const ClassicHeader(),
        footer: const ClassicFooter(),
        onRefresh: () async {
          await controller.fetchEventOrders();
          if (mounted) {
            refreshController.resetNoData();
            refreshController.refreshCompleted();
          }
        },
        onLoading: () async {
          await controller.fetchEventOrders(loadMore: true);
          if (mounted) {
            if (controller.eventCurrentPage.value >= controller.eventLastPage.value) {
              refreshController.loadNoData();
            } else {
              refreshController.loadComplete();
            }
          }
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return EventOrderCard(
              order: orders[index],
            );
          },
        ),
      );
    });
  }

  Widget _buildLoading() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 160,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'no_current_orders'.tr,
            style: context.typography.base.copyWith(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
