import 'package:image_picker/image_picker.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/features/components/widget/upload_photo.dart';

import 'package:sukientotapp/features/partner/show/controller.dart';

class UploadArrivedPhoto extends StatelessWidget {
  const UploadArrivedPhoto({
    super.key,
    required this.code,
    required this.billId,
  });

  final String code;
  final int billId;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: context.fTheme.colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 4),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: context.fTheme.colors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'upload_arrived_photo'.tr,
                        style: context.typography.xl.copyWith(
                          fontWeight: FontWeight.w700,
                          color: context.fTheme.colors.foreground,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        code,
                        style: context.typography.sm.copyWith(
                          color: context.fTheme.colors.mutedForeground,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: context.fTheme.colors.muted,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      FIcons.x,
                      size: 14,
                      color: context.fTheme.colors.mutedForeground,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Divider(height: 1, color: context.fTheme.colors.border),

          // Body
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info banner
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          FIcons.info,
                          size: 14,
                          color: Color(0xFF1D4ED8),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'upload_arrived_photo_desc'.tr,
                            style: context.typography.xs.copyWith(
                              color: const Color(0xFF1D4ED8),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Upload area
                  UploadPhoto(
                    onImagePicked: (XFile image) {
                      Get.find<ShowController>().selectedImage.value = image;
                    },
                    onImageRemoved: () {
                      Get.find<ShowController>().selectedImage.value = null;
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Action buttons
          Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              MediaQuery.of(context).padding.bottom + 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: context.fTheme.colors.muted,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: context.fTheme.colors.border,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'cancel'.tr,
                          style: context.typography.sm.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.fTheme.colors.foreground,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        Get.find<ShowController>().markInJob(billId),
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF3B82F6).withValues(
                              alpha: 0.35,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FIcons.mapPinCheck,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'confirm'.tr,
                            style: context.typography.sm.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
