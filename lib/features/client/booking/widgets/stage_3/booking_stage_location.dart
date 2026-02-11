import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/booking/controller.dart';
import '../booking_fields.dart';
import '../booking_layout.dart';
import '../booking_option_sheet.dart';

class BookingLocationStage extends GetView<ClientBookingController> {
  const BookingLocationStage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Icon(
                FIcons.mapPin,
                size: 64,
                color: context.fTheme.colors.mutedForeground,
              ),
              const SizedBox(height: 12),
              Text(
                'booking_stage_location_title'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                'booking_stage_location_subtitle'.tr,
                textAlign: TextAlign.center,
                style: context.typography.base.copyWith(
                  color: context.fTheme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        BookingTwoColumnRow(
          left: Obx(
            () => BookingSelectField(
              label: 'booking_location'.tr,
              value: controller.selectedProvince.value,
              placeholder: 'booking_select_province'.tr,
              onTap: () => _showOptions(
                title: 'booking_location'.tr,
                options: controller.provinces,
                selectedValue: controller.selectedProvince.value,
                onSelect: controller.selectProvince,
              ),
            ),
          ),
          right: Obx(
            () => BookingSelectField(
              label: 'booking_location_ward'.tr,
              value: controller.selectedWard.value,
              placeholder: 'booking_select_ward'.tr,
              onTap: () => _showOptions(
                title: 'booking_location_ward'.tr,
                options: controller.wards,
                selectedValue: controller.selectedWard.value,
                onSelect: controller.selectWard,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        BookingTextField(
          label: 'booking_address_detail'.tr,
          hint: 'booking_address_placeholder'.tr,
          controller: controller.addressDetailController,
        ),
      ],
    );
  }

  void _showOptions({
    required String title,
    required List<String> options,
    required String selectedValue,
    required ValueChanged<String> onSelect,
  }) {
    if (options.isEmpty) return;
    Get.bottomSheet(
      BookingOptionSheet(
        title: title,
        options: options,
        selectedValue: selectedValue,
        onSelect: onSelect,
      ),
      isScrollControlled: true,
    );
  }
}
