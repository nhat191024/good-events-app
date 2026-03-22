import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/partner/service_model.dart';
import '../controller.dart';

class ManageServiceMediaSheet extends GetView<MyServicesController> {
  const ManageServiceMediaSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 48,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => Text(
                          '${'manage_service_images'.tr} (${controller.serviceImages.length}/10)',
                          style: context.typography.lg.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // Body
              Expanded(
                child: Obx(() {
                  if (controller.isMediaLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                    children: [
                      // Image grid
                      if (controller.serviceImages.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Column(
                            children: [
                              Icon(
                                FIcons.image,
                                size: 48,
                                color: context.fTheme.colors.mutedForeground,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'no_images_yet'.tr,
                                style: context.typography.base.copyWith(
                                  color: context.fTheme.colors.mutedForeground,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.serviceImages.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 1,
                              ),
                          itemBuilder: (context, index) {
                            final img = controller.serviceImages[index];
                            return _ImageTile(image: img);
                          },
                        ),

                      const SizedBox(height: 24),

                      // Add images button
                      Obx(() {
                        final atLimit = controller.serviceImages.length >= 10;
                        final uploading = controller.isUploadingImages.value;
                        return FButton(
                          onPress: (atLimit || uploading)
                              ? null
                              : controller.pickAndUploadImages,
                          style: FButtonStyle.outline(),
                          child: uploading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text('uploading_images'.tr),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      atLimit
                                          ? 'images_limit_reached'.tr
                                          : 'add_images'.tr,
                                    ),
                                  ],
                                ),
                        );
                      }),
                    ],
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ImageTile extends GetView<MyServicesController> {
  final ServiceImageModel image;

  const _ImageTile({required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: image.thumb.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: image.thumb,
                  fit: BoxFit.cover,
                  placeholder: (_, _) => Container(
                    color: context.fTheme.colors.secondary,
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: context.fTheme.colors.mutedForeground,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (_, _, _) => Container(
                    color: context.fTheme.colors.secondary,
                    child: Icon(
                      FIcons.imageOff,
                      color: context.fTheme.colors.mutedForeground,
                    ),
                  ),
                )
              : Container(
                  color: context.fTheme.colors.secondary,
                  child: Icon(
                    FIcons.image,
                    color: context.fTheme.colors.mutedForeground,
                  ),
                ),
        ),

        // Delete overlay button
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => _confirmDelete(context),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 14),
            ),
          ),
        ),

        // File name tooltip at bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.55),
                  Colors.transparent,
                ],
              ),
            ),
            child: Text(
              image.fileName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'delete_image_confirm_title'.tr,
          style: context.typography.base.copyWith(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'delete_image_confirm_desc'.tr,
          style: context.typography.sm,
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('cancel'.tr)),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteServiceImage(image.id);
            },
            child: Text(
              'delete'.tr,
              style: TextStyle(color: context.fTheme.colors.destructive),
            ),
          ),
        ],
      ),
    );
  }
}
