import 'package:sukientotapp/core/utils/import/global.dart';
import '../../controller.dart';
import 'event_order_card.dart';

class CurrentOrdersTab extends StatelessWidget {
  const CurrentOrdersTab({super.key, required this.controller});

  final ClientOrderController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingEventOrders.value) {
        return _buildLoading();
      }

      final orders = controller.currentEventOrders;

      if (orders.isEmpty) {
        return _buildEmpty(context);
      }

      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!controller.isFetchingMoreEvent.value &&
              scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 100) {
            controller.fetchEventOrders(loadMore: true);
          }
          return false;
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orders.length + (controller.isFetchingMoreEvent.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == orders.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
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
