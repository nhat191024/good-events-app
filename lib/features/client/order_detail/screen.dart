import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';
import 'widgets/order_detail_header.dart';
import 'widgets/partner_section.dart';
import 'widgets/arrival_photo_section.dart';
import 'widgets/detailed_info_section.dart';
import 'widgets/bottom_actions.dart';

class ClientOrderDetailScreen extends GetView<ClientOrderDetailController> {
  const ClientOrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Flexible(
          child: Text(
            'back_to_list'.tr,
            style: context.typography.sm.copyWith(color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const OrderDetailHeader(),
              const SizedBox(height: 16),
              const PartnerSection(),
              const SizedBox(height: 16),
              const ArrivalPhotoSection(),
              const SizedBox(height: 24),
              const DetailedInfoSection(),
              const SizedBox(height: 100), // Bottom padding for fixed buttons
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomActions(),
    );
  }
}
