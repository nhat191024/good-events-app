import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/partner_detail/controller.dart';
import 'package:flutter_html/flutter_html.dart';
import 'inline_video_player.dart';

class PartnerContentWidget extends StatelessWidget {
  final PartnerDetailController controller;

  const PartnerContentWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24), // lg:p-10 equivalent-ish
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
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
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ), // Gray-500
          ),
          const SizedBox(height: 32), // Space-y-8
          // Video Section
          const Text(
            'Video',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () {
              if (controller.videoUrl.value.isEmpty) {
                return const SizedBox.shrink();
              }
              return InlineVideoPlayer(
                htmlContent: controller.videoUrl.value,
                thumbnailUrl: controller.getThumbnail(),
                onTapExternal: () {
                  final url = controller.getVideoUrl();
                  if (url.isNotEmpty) {
                    Get.toNamed(
                      Routes.webView,
                      arguments: {
                        'url': url,
                        'title': 'Video ${controller.partnerName.value}',
                        'allowReload': true,
                      },
                    );
                  }
                },
              );
            },
          ),
          const SizedBox(height: 32),

          // Description Text
          Obx(
            () => Html(
              data: controller.description.value,
              style: {
                "body": Style(
                  fontSize: FontSize(14),
                  lineHeight: LineHeight(1.6),
                  color: const Color(0xFF374151), // Gray-700
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
