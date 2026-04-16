import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';
import 'history_order_card.dart';

class HistoryOrdersTab extends StatefulWidget {
  const HistoryOrdersTab({super.key, required this.controller});

  final ClientOrderController controller;

  @override
  State<HistoryOrdersTab> createState() => _HistoryOrdersTabState();
}

class _HistoryOrdersTabState extends State<HistoryOrdersTab> {
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
      if (controller.isLoadingHistoryOrders.value && controller.historyOrders.isEmpty) {
        return _buildLoading();
      }

      final orders = controller.filteredHistoryOrders;

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
          await controller.fetchHistoryOrders();
          if (mounted) {
            refreshController.resetNoData();
            refreshController.refreshCompleted();
          }
        },
        onLoading: () async {
          await controller.fetchHistoryOrders(loadMore: true);
          if (mounted) {
            if (controller.historyCurrentPage.value >= controller.historyLastPage.value) {
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
            return HistoryOrderCard(order: orders[index]);
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
          Icon(Icons.history, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'no_history_orders'.tr,
            style: context.typography.base.copyWith(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
