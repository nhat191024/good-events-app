import 'package:sukientotapp/core/utils/import/global.dart';
import '../controller.dart';

class OrderDetailHeader extends GetView<ClientOrderDetailController> {
  const OrderDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Obx(
                () => Text(
                  '${'order_details_title'.tr} - ${controller.orderCode}',
                  style: context.typography.xl.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.refresh, color: Colors.grey[500]),
                  onPressed: () {},
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    border: Border.all(color: Colors.red[200]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.flag, color: Colors.red, size: 16),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
