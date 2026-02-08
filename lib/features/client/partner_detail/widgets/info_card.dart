import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/partner_detail/controller.dart';

import 'package:sukientotapp/features/components/widget/badge.dart';

class PartnerInfoCard extends StatelessWidget {
  final PartnerDetailController controller;

  const PartnerInfoCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag
          Obx(
            () => CustomBadge(
              text: controller.subCategory.value,
              backgroundColor: const Color(0xFFF0F9FF),
              textColor: const Color(0xFF0369A1),
            ),
          ),
          const SizedBox(height: 8),

          // Title
          Obx(
            () => Text(
              controller.serviceType.value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827), // Gray-900
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Update Info
          Obx(
            () => Row(
              children: [
                Text(
                  'last_update'.tr.replaceAll('@time', controller.updateTime.value),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF374151),
                  ), // Gray-700
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Price Box
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F9FF).withOpacity(0.6), // Primary-50/60
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE0F2FE)), // Primary-100
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'reference_price'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E40AF), // Primary-800
                  ),
                ),
                const SizedBox(height: 4),
                Obx(
                  () => Text(
                    controller.priceRange.value,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E3A8A), // Primary-900
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'contact_to_get_detail_and_best_deal'.tr,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xB31D4ED8), // Primary-700/70
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Commitments
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB), // Gray-50
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF3F4F6)), // Gray-100
            ),
            child: Column(
              children:
                  ['partner_trustworthy'.tr, 'partner_professional'.tr, 'partner_competitive'.tr]
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Color(0xFF2563EB),
                                ), // Primary-600
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF4B5563),
                                  ), // Gray-600
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
