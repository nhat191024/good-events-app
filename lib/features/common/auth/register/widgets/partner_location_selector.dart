import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/auth/register/controller.dart';
import 'package:sukientotapp/data/models/location_model.dart';

class PartnerLocationSelector extends GetView<RegisterController> {
  const PartnerLocationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'province_city'.tr,
          style: context.typography.sm.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Obx(
          () => OutlinedButton(
            onPressed: controller.isFetchingProvinces.value
                ? null
                : () {
                    _showLocationBottomSheet(
                      context,
                      title: 'province_city'.tr,
                      items: controller.provinces,
                      selectedValue: controller.selectedProvince.value,
                      onSelect: (item) {
                        controller.selectProvince(item);
                        Get.back();
                      },
                    );
                  },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: context.fTheme.colors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              minimumSize: const Size(double.infinity, 44),
              alignment: Alignment.centerLeft,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (controller.isFetchingProvinces.value)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.fTheme.colors.primary,
                    ),
                  )
                else
                  Text(
                    controller.selectedProvince.value?.name ??
                        'select_province_hint'.tr,
                    style: TextStyle(
                      color: controller.selectedProvince.value != null
                          ? context.fTheme.colors.foreground
                          : context.fTheme.colors.mutedForeground,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                Icon(
                  FIcons.chevronDown,
                  size: 16,
                  color: context.fTheme.colors.mutedForeground,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        Text(
          'ward_district'.tr,
          style: context.typography.sm.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Obx(
          () => OutlinedButton(
            onPressed:
                controller.selectedProvince.value == null ||
                    controller.isFetchingWards.value
                ? null
                : () {
                    _showLocationBottomSheet(
                      context,
                      title: 'ward_district'.tr,
                      items: controller.wards,
                      selectedValue: controller.selectedWard.value,
                      onSelect: (item) {
                        controller.selectWard(item);
                        Get.back();
                      },
                    );
                  },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: context.fTheme.colors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              minimumSize: const Size(double.infinity, 44),
              alignment: Alignment.centerLeft,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (controller.isFetchingWards.value)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.fTheme.colors.primary,
                    ),
                  )
                else
                  Text(
                    controller.selectedWard.value?.name ??
                        'select_ward_hint'.tr,
                    style: TextStyle(
                      color: controller.selectedWard.value != null
                          ? context.fTheme.colors.foreground
                          : context.fTheme.colors.mutedForeground,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                Icon(
                  FIcons.chevronDown,
                  size: 16,
                  color: context.fTheme.colors.mutedForeground,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _removeDiacritics(String str) {
    // this makes "Hà Nội" and 'ha noi' match up
    // not a perfect solution but it is good enough for now
    const withDiacritics =
        'áàảãạâấầẩẫậăắằẳẵặđéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵ';
    const withoutDiacritics =
        'aaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyy';
    var lowerStr = str.toLowerCase();
    for (int i = 0; i < withDiacritics.length; i++) {
      lowerStr = lowerStr.replaceAll(withDiacritics[i], withoutDiacritics[i]);
    }
    return lowerStr;
  }

  void _showLocationBottomSheet(
    BuildContext context, {
    required String title,
    required List<LocationModel> items,
    required LocationModel? selectedValue,
    required Function(LocationModel) onSelect,
  }) {
    final query = ''.obs;

    Get.bottomSheet(
      Material(
        color: context.fTheme.colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              Text(
                title,
                style: context.typography.lg.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'search_with_dot'.tr,
                    prefixIcon: const Icon(Icons.search, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (val) => query.value = val,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  final String q = _removeDiacritics(query.value);
                  final filteredItems = items.where((item) {
                    final normalizedName = _removeDiacritics(item.name);
                    return normalizedName.contains(q);
                  }).toList();

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      final isSelected = selectedValue?.id == item.id;

                      return InkWell(
                        onTap: () => onSelect(item),
                        borderRadius: BorderRadius.circular(0),
                        child: Padding(
                          // Slightly increased vertical padding so it's easier to tap,
                          // but kept it small so the list stays dense.
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  FIcons.check,
                                  color: context.fTheme.colors.primary,
                                  size: 18,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: false,
    );
  }
}
