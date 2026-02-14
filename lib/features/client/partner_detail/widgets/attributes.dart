import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/partner_detail/controller.dart';

class PartnerAttributesWidget extends StatelessWidget {
  final PartnerDetailController controller;

  const PartnerAttributesWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'main_info'.tr,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            // Simple grid layout replacement using wrap
            return Obx(
              () => Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildAttributeCard('type'.tr, 'Sự kiện', constraints.maxWidth),
                  _buildAttributeCard(
                    'field'.tr,
                    controller.subCategory.value,
                    constraints.maxWidth,
                  ),
                  _buildAttributeCard(
                    'partner_type'.tr,
                    controller.serviceType.value,
                    constraints.maxWidth,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAttributeCard(String title, String value, double maxWidth) {
    // Responsive width calculation roughly like grid-cols-1 sm:grid-cols-2 md:grid-cols-3
    double width = (maxWidth - 32) / 2; // Default to 2 cols for mobile
    if (maxWidth < 600) width = maxWidth; // 1 col for very small screens

    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB), // Gray-50
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151), // Gray-700
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4B5563), // Gray-600
            ),
          ),
        ],
      ),
    );
  }
}
