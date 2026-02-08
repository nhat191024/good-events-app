import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/partner_detail/controller.dart';
// import 'package:webview_flutter/webview_flutter.dart'; // Consider if webview is needed for video iframe

class PartnerContentWidget extends StatelessWidget {
  final PartnerDetailController controller;

  const PartnerContentWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24), // lg:p-10 equivalent-ish
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'detailed_info'.tr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827), // Gray-900
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${'detailed_info'.tr.capitalizeFirst} ${'about_the'.tr} ${'service'.tr.toLowerCase()} ${'and'.tr.toLowerCase()} ${'partner'.tr.toLowerCase()}',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)), // Gray-500
          ),
          const SizedBox(height: 32), // Space-y-8
          // Video Section
          const Text(
            'Video',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 200, // Aspect ratio proxy
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB), // Gray-50
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF3F4F6)),
            ),
            child: const Center(child: Icon(Icons.play_circle_fill, size: 50, color: Colors.grey)),
          ),
          const SizedBox(height: 32),

          // Description Text
          Obx(
            () => Text(
              controller.description.value,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF374151), // Gray-700
              ),
            ),
          ),
        ],
      ),
    );
  }
}
