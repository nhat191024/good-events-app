import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/booking/controller.dart';
import 'package:sukientotapp/features/components/button/plus.dart';

class BookingPhotoStage extends GetView<ClientBookingController> {
  const BookingPhotoStage({super.key});

  static final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Icon(
                FIcons.image,
                size: 64,
                color: context.fTheme.colors.mutedForeground,
              ),
              const SizedBox(height: 12),
              Text(
                'booking_stage_photo_title'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'booking_stage_photo_subtitle'.tr,
                textAlign: TextAlign.center,
                style: context.typography.base.copyWith(
                  color: context.fTheme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Obx(() {
          final XFile? photo = controller.bookingPhoto.value;
          final String? errorText = controller.fieldErrors['bookingPhoto'];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.fTheme.colors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: errorText == null
                        ? context.fTheme.colors.border
                        : AppColors.red600,
                  ),
                ),
                child: photo == null
                    ? _EmptyPhotoPicker(
                        onPickGallery: () => _pickPhoto(ImageSource.gallery),
                        onPickCamera: () => _pickPhoto(ImageSource.camera),
                      )
                    : _SelectedPhotoPreview(
                        photo: photo,
                        onChange: () => _pickPhoto(ImageSource.gallery),
                        onRemove: controller.removeBookingPhoto,
                      ),
              ),
              if (errorText != null) ...[
                const SizedBox(height: 6),
                Text(
                  errorText,
                  style: context.typography.sm.copyWith(
                    color: AppColors.red600,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Text(
                'booking_stage_photo_subtitle_2'.tr,
                textAlign: TextAlign.center,
                style: context.typography.sm.copyWith(
                  color: context.fTheme.colors.mutedForeground,
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Future<void> _pickPhoto(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return;

      await controller.selectBookingPhoto(image);
    } catch (e) {
      logger.e('[BookingPhotoStage] Failed to pick image: $e');
      Get.snackbar('error'.tr, 'booking_stage_photo_cannot_select'.tr);
    }
  }
}

class _EmptyPhotoPicker extends StatelessWidget {
  const _EmptyPhotoPicker({
    required this.onPickGallery,
    required this.onPickCamera,
  });

  final VoidCallback onPickGallery;
  final VoidCallback onPickCamera;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          FIcons.imagePlus,
          size: 40,
          color: context.fTheme.colors.mutedForeground,
        ),
        const SizedBox(height: 10),
        Text(
          'booking_stage_photo_empty'.tr,
          style: context.typography.base.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          'booking_stage_photo_empty_subtitle'.tr,
          textAlign: TextAlign.center,
          style: context.typography.sm.copyWith(
            color: context.fTheme.colors.mutedForeground,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomButtonPlus(
                onTap: onPickGallery,
                btnText: 'choose_picture'.tr,
                icon: FIcons.image,
                iconSize: 16,
                textSize: 14,
                height: 40,
                borderRadius: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.red600,
                textColor: Colors.white,
                borderColor: Colors.transparent,
                shrinkText: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomButtonPlus(
                onTap: onPickCamera,
                btnText: 'take_photo'.tr,
                icon: FIcons.camera,
                iconSize: 16,
                textSize: 14,
                height: 40,
                borderRadius: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                textColor: AppColors.lightForeground,
                borderColor: context.fTheme.colors.border,
                shrinkText: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SelectedPhotoPreview extends StatelessWidget {
  const _SelectedPhotoPreview({
    required this.photo,
    required this.onChange,
    required this.onRemove,
  });

  final XFile photo;
  final VoidCallback onChange;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(File(photo.path), height: 220, fit: BoxFit.cover),
        ),
        const SizedBox(height: 12),
        Text(
          photo.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.typography.sm.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CustomButtonPlus(
                onTap: onChange,
                btnText: 'change_photo'.tr,
                icon: FIcons.refreshCw,
                iconSize: 14,
                textSize: 13,
                height: 38,
                borderRadius: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.red600,
                textColor: Colors.white,
                borderColor: Colors.transparent,
                shrinkText: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomButtonPlus(
                onTap: onRemove,
                btnText: 'remove_photo'.tr,
                icon: FIcons.trash,
                iconSize: 14,
                textSize: 13,
                height: 38,
                borderRadius: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                textColor: AppColors.lightForeground,
                borderColor: context.fTheme.colors.border,
                shrinkText: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
