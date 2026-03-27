import 'package:flutter/cupertino.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

class FilterSheetWidget extends StatefulWidget {
  const FilterSheetWidget({
    super.key,
    required this.initialSearch,
    required this.initialDate,
    required this.initialSort,
    required this.onApply,
    required this.onClear,
  });

  final String initialSearch;
  final String initialDate;
  final String initialSort;
  final void Function({
    required String search,
    required String dateFilter,
    required String sort,
  }) onApply;
  final VoidCallback onClear;

  @override
  State<FilterSheetWidget> createState() => _FilterSheetWidgetState();
}

class _FilterSheetWidgetState extends State<FilterSheetWidget> {
  late String _dateFilter;
  late String _sort;
  late TextEditingController _searchCtrl;

  static const _dateOptions = ['all', 'today', 'this_week', 'this_month'];
  static const _sortOptions = ['date_asc', 'date_desc', 'price_asc', 'price_desc'];

  @override
  void initState() {
    super.initState();
    _dateFilter = widget.initialDate;
    _sort = widget.initialSort;
    _searchCtrl = TextEditingController(text: widget.initialSearch);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Padding(
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
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'filter_orders'.tr,
                    style: context.typography.xl.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.fTheme.colors.foreground,
                    ),
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
                      CupertinoIcons.xmark,
                      size: 14,
                      color: context.fTheme.colors.mutedForeground,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search
                  _SectionLabel(label: 'search_with_dot'.tr),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _searchCtrl,
                    style: context.typography.sm,
                    decoration: InputDecoration(
                      hintText: 'search_orders_hint'.tr,
                      hintStyle: context.typography.sm.copyWith(
                        color: context.fTheme.colors.mutedForeground,
                      ),
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        size: 18,
                        color: context.fTheme.colors.mutedForeground,
                      ),
                      filled: true,
                      fillColor: context.fTheme.colors.muted,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: context.fTheme.colors.border,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: context.fTheme.colors.border,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: context.fTheme.colors.primary,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Date Filter
                  _SectionLabel(label: 'date_filter_label'.tr),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _dateOptions.map((val) {
                      final isSelected = _dateFilter == val;
                      return _FilterChip(
                        label: 'date_$val'.tr,
                        isSelected: isSelected,
                        onTap: () => setState(() => _dateFilter = val),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  // Sort
                  _SectionLabel(label: 'sort_label'.tr),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _sortOptions.map((val) {
                      final isSelected = _sort == val;
                      return _FilterChip(
                        label: 'sort_$val'.tr,
                        isSelected: isSelected,
                        onTap: () => setState(() => _sort = val),
                      );
                    }).toList(),
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
              MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onClear();
                      Get.back();
                    },
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: context.fTheme.colors.muted,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: context.fTheme.colors.border,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'clear_filter'.tr,
                        style: context.typography.sm.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.fTheme.colors.foreground,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      widget.onApply(
                        search: _searchCtrl.text.trim(),
                        dateFilter: _dateFilter,
                        sort: _sort,
                      );
                      Get.back();
                    },
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: context.fTheme.colors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'apply_filter'.tr,
                        style: context.typography.sm.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.typography.sm.copyWith(
        fontWeight: FontWeight.w600,
        color: context.fTheme.colors.foreground,
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? context.fTheme.colors.primary.withValues(alpha: 0.1)
              : context.fTheme.colors.muted,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? context.fTheme.colors.primary.withValues(alpha: 0.4)
                : context.fTheme.colors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          label,
          style: context.typography.xs.copyWith(
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected
                ? context.fTheme.colors.primary
                : context.fTheme.colors.foreground,
          ),
        ),
      ),
    );
  }
}
