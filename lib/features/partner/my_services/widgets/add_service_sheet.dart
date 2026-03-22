import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/partner/service_model.dart';
import '../controller.dart';

class AddServiceSheet extends GetView<MyServicesController> {
  const AddServiceSheet({super.key});

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
                      child: Text(
                        'add_service'.tr,
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
                  if (controller.isAddSheetLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                    children: [
                      // Category
                      Text(
                        'category'.tr,
                        style: context.typography.sm.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.fTheme.colors.mutedForeground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => _AddCategoryDropdown(
                          categories: controller.categories,
                          selectedId: controller.addSelectedCategoryId.value,
                          onSelect: (id) =>
                              controller.addSelectedCategoryId.value = id,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Media section header
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'service_media_info'.tr,
                              style: context.typography.sm.copyWith(
                                fontWeight: FontWeight.w600,
                                color: context.fTheme.colors.mutedForeground,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.addMediaEntry,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  FIcons.plus,
                                  size: 16,
                                  color: context.fTheme.colors.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'add_media'.tr,
                                  style: context.typography.sm.copyWith(
                                    color: context.fTheme.colors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Media repeater
                      Obx(() {
                        if (controller.addMediaEntries.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              'no_media_yet'.tr,
                              style: context.typography.sm.copyWith(
                                color: context.fTheme.colors.mutedForeground,
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: controller.addMediaEntries
                              .asMap()
                              .entries
                              .map(
                                (e) => _MediaEntryItem(
                                  index: e.key,
                                  entry: e.value,
                                  onRemove: () =>
                                      controller.removeMediaEntry(e.key),
                                ),
                              )
                              .toList(),
                        );
                      }),

                      const SizedBox(height: 24),

                      // Submit button
                      Obx(
                        () => FButton(
                          onPress: controller.isCreating.value
                              ? null
                              : controller.submitCreateService,
                          child: controller.isCreating.value
                              ? Text('loading_with_dot'.tr)
                              : Text('add_service'.tr),
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

// ─── Category Dropdown ────────────────────────────────────────────────────────

class _AddCategoryDropdown extends StatelessWidget {
  final List<ServiceCategoryModel> categories;
  final String selectedId;
  final ValueChanged<String> onSelect;

  const _AddCategoryDropdown({
    required this.categories,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final selected = categories.where((c) => c.id == selectedId).firstOrNull;

    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          _AddCategoryPickerSheet(
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

class _AddCategoryPickerSheet extends StatelessWidget {
  final List<ServiceCategoryModel> categories;
  final String selectedId;
  final ValueChanged<String> onSelect;

  const _AddCategoryPickerSheet({
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

// ─── Media Entry Item (Repeater Row) ─────────────────────────────────────────

class _MediaEntryItem extends StatelessWidget {
  final int index;
  final ServiceMediaEntry entry;
  final VoidCallback onRemove;

  const _MediaEntryItem({
    required this.index,
    required this.entry,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: context.fTheme.colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${'media_item'.tr} ${index + 1}',
                style: context.typography.sm.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onRemove,
                child: Icon(
                  FIcons.trash2,
                  size: 18,
                  color: context.fTheme.colors.destructive,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // URL (required)
          _buildField(
            context,
            label: '${'media_url'.tr} *',
            controller: entry.urlController,
            hint: 'https://youtube.com/watch?v=...',
          ),
          const SizedBox(height: 10),

          // Name (required)
          _buildField(
            context,
            label: '${'media_name'.tr} *',
            controller: entry.nameController,
            hint: 'media_name_hint'.tr,
          ),
          const SizedBox(height: 10),

          // Description
          _buildField(
            context,
            label: 'media_description'.tr,
            controller: entry.descriptionController,
            hint: 'media_description_hint'.tr,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    String? hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.typography.xs.copyWith(
            fontWeight: FontWeight.w500,
            color: context.fTheme.colors.mutedForeground,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: context.typography.sm.copyWith(
              color: context.fTheme.colors.mutedForeground,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.fTheme.colors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.fTheme.colors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.fTheme.colors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
