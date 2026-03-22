import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/partner/service_model.dart';
import '../controller.dart';

class EditServiceSheet extends GetView<MyServicesController> {
  const EditServiceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
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
                      child: Text(
                        'edit'.tr,
                        style: context.typography.lg.copyWith(
                          fontWeight: FontWeight.w700,
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
                  if (controller.isSheetLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final detail = controller.sheetDetail.value;
                  if (detail == null) {
                    return const SizedBox.shrink();
                  }

                  return ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                    children: [
                      // Category dropdown
                      Text(
                        'category'.tr,
                        style: context.typography.sm.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.fTheme.colors.mutedForeground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => _CategoryDropdown(
                          categories: controller.categories,
                          selectedId: controller.selectedCategoryId.value,
                          onSelect: (id) =>
                              controller.selectedCategoryId.value = id,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Service media (read-only)
                      if (detail.serviceMedia.isNotEmpty) ...[
                        Text(
                          'service_media_info'.tr,
                          style: context.typography.sm.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.fTheme.colors.mutedForeground,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...detail.serviceMedia
                            .map((m) => _MediaItem(media: m)),
                        const SizedBox(height: 24),
                      ],

                      // Save button
                      Obx(
                        () => FButton(
                          onPress: controller.isSaving.value
                              ? null
                              : controller.saveService,
                          child: controller.isSaving.value
                              ? Text('loading_with_dot'.tr)
                              : Text('save'.tr),
                        ),
                      ),
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

class _CategoryDropdown extends StatelessWidget {
  final List<ServiceCategoryModel> categories;
  final String selectedId;
  final ValueChanged<String> onSelect;

  const _CategoryDropdown({
    required this.categories,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final selected =
        categories.where((c) => c.id == selectedId).firstOrNull;

    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          _CategoryPickerSheet(
            categories: categories,
            selectedId: selectedId,
            onSelect: onSelect,
          ),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: context.fTheme.colors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selected?.name ?? 'select_category'.tr,
                style: context.typography.base.copyWith(
                  color: selected != null
                      ? context.fTheme.colors.foreground
                      : context.fTheme.colors.mutedForeground,
                ),
              ),
            ),
            Icon(
              FIcons.chevronDown,
              size: 18,
              color: context.fTheme.colors.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryPickerSheet extends StatelessWidget {
  final List<ServiceCategoryModel> categories;
  final String selectedId;
  final ValueChanged<String> onSelect;

  const _CategoryPickerSheet({
    required this.categories,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'category'.tr,
                      style: context.typography.lg.copyWith(
                        fontWeight: FontWeight.w600,
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
            const SizedBox(height: 4),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: categories.length,
                separatorBuilder: (_, _) => Divider(
                  height: 1,
                  color: Colors.black.withValues(alpha: 0.08),
                ),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = cat.id == selectedId;
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8),
                    title: Text(cat.name),
                    trailing: isSelected
                        ? Icon(Icons.check,
                            color: context.fTheme.colors.primary)
                        : null,
                    onTap: () {
                      onSelect(cat.id);
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MediaItem extends StatelessWidget {
  final ServiceMediaModel media;

  const _MediaItem({required this.media});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.fTheme.colors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.fTheme.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(FIcons.link, size: 16, color: context.fTheme.colors.mutedForeground),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  media.name.isNotEmpty ? media.name : media.url,
                  style: context.typography.sm.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (media.url.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              media.url,
              style: context.typography.xs.copyWith(
                color: context.fTheme.colors.primary,
                decoration: TextDecoration.underline,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (media.description.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              media.description,
              style: context.typography.xs.copyWith(
                color: context.fTheme.colors.mutedForeground,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
