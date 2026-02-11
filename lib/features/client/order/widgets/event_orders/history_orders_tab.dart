import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';
import 'event_order_card.dart';

class HistoryOrdersTab extends StatelessWidget {
  const HistoryOrdersTab({super.key, required this.controller});

  final ClientOrderController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingEventOrders.value) {
        return _buildLoading();
      }

      final orders = controller.historyEventOrders;

      if (orders.isEmpty) {
        return _buildEmpty(context);
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return EventOrderCard(
            order: orders[index],
            isSelected: false,
          );
        },
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
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'no_history_orders'.tr,
            style: context.typography.base.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
