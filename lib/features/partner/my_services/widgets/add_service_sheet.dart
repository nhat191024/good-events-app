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
          decoration: BoxDecoration(
            color: context.fTheme.colors.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                decoration: BoxDecoration(
                  color: context.fTheme.colors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'add_service'.tr,
                            style: context.typography.xl.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'add_service_subtitle'.tr,
                            style: context.typography.sm.copyWith(
                              color: context.fTheme.colors.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: context.fTheme.colors.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          FIcons.x,
                          size: 18,
                          color: context.fTheme.colors.mutedForeground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: context.fTheme.colors.border),
              // Body
              Expanded(
                child: Obx(() {
                  if (controller.isAddSheetLoading.value) {
                    return const _AddSheetSkeleton();
                  }

                  return ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    children: [
                      // ── Section 1: Category ──────────────────────────
                      _SheetSectionLabel(number: 1, title: 'category'.tr)
                          .animate(delay: 100.ms)
                          .fadeIn(duration: 300.ms)
                          .slideY(begin: -0.02, end: 0, curve: Curves.easeOut),
                      const SizedBox(height: 12),
                      Obx(
                        () => _AddCategoryDropdown(
                          categories: controller.categories,
                          selectedId: controller.addSelectedCategoryId.value,
                          onSelect: (id) =>
                              controller.addSelectedCategoryId.value = id,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // ── Section 2: Media ─────────────────────────────
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _SheetSectionLabel(
                                number: 2,
                                title: 'service_media_info'.tr,
                              )
                              .animate(delay: 300.ms)
                              .fadeIn(duration: 300.ms)
                              .slideY(
                                begin: -0.02,
                                end: 0,
                                curve: Curves.easeOut,
                              ),
                          const SizedBox(height: 8),
                          GestureDetector(
                                onTap: controller.addMediaEntry,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: context.fTheme.colors.primary
                                        .withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        FIcons.plus,
                                        size: 13,
                                        color: context.fTheme.colors.primary,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'add_media'.tr,
                                        style: context.typography.xs.copyWith(
                                          color: context.fTheme.colors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .animate(delay: 300.ms)
                              .fadeIn(duration: 300.ms)
                              .slideY(
                                begin: -0.02,
                                end: 0,
                                curve: Curves.easeOut,
                              ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Media repeater
                      Obx(() {
                        if (controller.addMediaEntries.isEmpty) {
                          return _MediaEmptyState();
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

                      const SizedBox(height: 32),

                      // Submit button
                      Obx(
                        () =>
                            FButton(
                                  onPress: controller.isCreating.value
                                      ? null
                                      : controller.submitCreateService,
                                  child: controller.isCreating.value
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: context
                                                    .fTheme
                                                    .colors
                                                    .primaryForeground,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text('loading_with_dot'.tr),
                                          ],
                                        )
                                      : Text('add_service'.tr),
                                )
                                .animate(delay: 500.ms)
                                .fadeIn(duration: 300.ms)
                                .slideY(
                                  begin: -0.02,
                                  end: 0,
                                  curve: Curves.easeOut,
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

// ─── Section Label with Numbered Badge ───────────────────────────────────────

class _SheetSectionLabel extends StatelessWidget {
  final int number;
  final String title;

  const _SheetSectionLabel({required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: context.fTheme.colors.primary,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text(
            '$number',
            style: context.typography.xs.copyWith(
              color: context.fTheme.colors.primaryForeground,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: context.typography.base.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

// ─── Loading Skeleton ─────────────────────────────────────────────────────────

class _AddSheetSkeleton extends StatelessWidget {
  const _AddSheetSkeleton();

  Widget _box(
    BuildContext context, {
    double height = 16,
    double? width,
    double radius = 8,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: context.fTheme.colors.secondary,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _box(context, height: 13, width: 90),
          const SizedBox(height: 12),
          _box(context, height: 52, radius: 12),
          const SizedBox(height: 28),
          _box(context, height: 13, width: 130),
          const SizedBox(height: 12),
          _box(context, height: 110, radius: 12),
        ],
      ),
    );
  }
}

// ─── Media Empty State ────────────────────────────────────────────────────────

class _MediaEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
          decoration: BoxDecoration(
            color: context.fTheme.colors.secondary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.fTheme.colors.border),
          ),
          child: Column(
            children: [
              Icon(
                FIcons.image,
                size: 28,
                color: context.fTheme.colors.mutedForeground,
              ),
              const SizedBox(height: 8),
              Text(
                'no_media_yet'.tr,
                style: context.typography.sm.copyWith(
                  color: context.fTheme.colors.mutedForeground,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'tap_add_media_hint'.tr,
                textAlign: TextAlign.center,
                style: context.typography.xs.copyWith(
                  color: context.fTheme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        )
        .animate(delay: 400.ms)
        .fadeIn(duration: 300.ms)
        .slideY(begin: -0.02, end: 0, curve: Curves.easeOut);
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
    final hasSelection = selected != null;

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
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: hasSelection
                  ? context.fTheme.colors.primary.withValues(alpha: 0.04)
                  : context.fTheme.colors.background,
              border: Border.all(
                color: hasSelection
                    ? context.fTheme.colors.primary.withValues(alpha: 0.4)
                    : context.fTheme.colors.border,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                if (hasSelection) ...[
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: context.fTheme.colors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
                Expanded(
                  child: Text(
                    selected?.name ?? 'select_category'.tr,
                    style: context.typography.base.copyWith(
                      color: hasSelection
                          ? context.fTheme.colors.foreground
                          : context.fTheme.colors.mutedForeground,
                      fontWeight: hasSelection
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                  ),
                ),
                Icon(
                  FIcons.chevronDown,
                  size: 16,
                  color: hasSelection
                      ? context.fTheme.colors.primary
                      : context.fTheme.colors.mutedForeground,
                ),
              ],
            ),
          ),
        )
        .animate(delay: 200.ms)
        .fadeIn(duration: 300.ms)
        .slideY(begin: -0.02, end: 0, curve: Curves.easeOut);
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
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      decoration: BoxDecoration(
        color: context.fTheme.colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: context.fTheme.colors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 12, 4),
              child: Row(
                children: [
                  Text(
                    'category'.tr,
                    style: context.typography.lg.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: context.fTheme.colors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        FIcons.x,
                        size: 16,
                        color: context.fTheme.colors.mutedForeground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: context.fTheme.colors.border),
            const SizedBox(height: 4),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = cat.id == selectedId;
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        onSelect(cat.id);
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 13,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? context.fTheme.colors.primary.withValues(
                                  alpha: 0.06,
                                )
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                cat.name,
                                style: context.typography.base.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? context.fTheme.colors.primary
                                      : context.fTheme.colors.foreground,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                FIcons.check,
                                size: 16,
                                color: context.fTheme.colors.primary,
                              ),
                          ],
                        ),
                      ),
                    ),
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
          decoration: BoxDecoration(
            color: context.fTheme.colors.background,
            border: Border.all(color: context.fTheme.colors.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Item header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: context.fTheme.colors.secondary,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(13),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: context.fTheme.colors.primary.withValues(
                          alpha: 0.12,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: context.typography.xs.copyWith(
                          color: context.fTheme.colors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${'media_item'.tr} ${index + 1}',
                      style: context.typography.sm.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: context.fTheme.colors.destructive.withValues(
                            alpha: 0.08,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(
                          FIcons.trash2,
                          size: 14,
                          color: context.fTheme.colors.destructive,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Fields
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    FTextFormField(
                      control: FTextFieldControl.managed(
                        controller: entry.urlController,
                      ),
                      label: Text('${'media_url'.tr} *'),
                      hint: 'https://youtube.com/watch?v=...',
                    ),
                    const SizedBox(height: 12),
                    FTextFormField(
                      control: FTextFieldControl.managed(
                        controller: entry.nameController,
                      ),
                      label: Text('${'media_name'.tr} *'),
                      hint: 'media_name_hint'.tr,
                    ),
                    const SizedBox(height: 12),
                    FTextFormField(
                      control: FTextFieldControl.managed(
                        controller: entry.descriptionController,
                      ),
                      label: Text('media_description'.tr),
                      hint: 'media_description_hint'.tr,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: -0.02, end: 0, curve: Curves.easeOut);
  }
}
