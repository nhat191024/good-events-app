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
                            'edit'.tr,
                            style: context.typography.xl.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'edit_service_subtitle'.tr,
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
                  if (controller.isSheetLoading.value) {
                    return const _EditSheetSkeleton();
                  }

                  final detail = controller.sheetDetail.value;
                  if (detail == null) {
                    return const SizedBox.shrink();
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
                        () => _CategoryDropdown(
                          categories: controller.categories,
                          selectedId: controller.selectedCategoryId.value,
                          onSelect: (id) =>
                              controller.selectedCategoryId.value = id,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // ── Section 2: Media (read-only) ─────────────────
                      if (detail.serviceMedia.isNotEmpty) ...[
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
                        const SizedBox(height: 12),
                        ...detail.serviceMedia.map((m) => _MediaItem(media: m)),
                        const SizedBox(height: 28),
                      ],

                      // Save button
                      Obx(
                        () =>
                            FButton(
                                  onPress: controller.isSaving.value
                                      ? null
                                      : controller.saveService,
                                  child: controller.isSaving.value
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
                                      : Text('save'.tr),
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

class _EditSheetSkeleton extends StatelessWidget {
  const _EditSheetSkeleton();

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
          _box(context, height: 90, radius: 12),
          const SizedBox(height: 4),
          _box(context, height: 90, radius: 12),
        ],
      ),
    );
  }
}

// ─── Category Dropdown ────────────────────────────────────────────────────────

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
    final selected = categories.where((c) => c.id == selectedId).firstOrNull;
    final hasSelection = selected != null;

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

class _MediaItem extends StatelessWidget {
  final ServiceMediaModel media;

  const _MediaItem({required this.media});

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: context.fTheme.colors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: context.fTheme.colors.border),
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
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: context.fTheme.colors.primary.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Icon(
                        FIcons.link,
                        size: 13,
                        color: context.fTheme.colors.primary,
                      ),
                    ),
                    const SizedBox(width: 10),
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
              ),
              // Info rows
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (media.url.isNotEmpty) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FIcons.externalLink,
                            size: 13,
                            color: context.fTheme.colors.mutedForeground,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              media.url,
                              style: context.typography.xs.copyWith(
                                color: context.fTheme.colors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: context.fTheme.colors.primary
                                    .withValues(alpha: 0.4),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (media.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FIcons.textQuote,
                            size: 13,
                            color: context.fTheme.colors.mutedForeground,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              media.description,
                              style: context.typography.xs.copyWith(
                                color: context.fTheme.colors.mutedForeground,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        )
        .animate(delay: 400.ms)
        .fadeIn(duration: 400.ms)
        .slideY(begin: -0.02, end: 0, curve: Curves.easeOut);
  }
}
