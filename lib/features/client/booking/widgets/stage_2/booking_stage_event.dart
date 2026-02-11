import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/booking/controller.dart';
import '../booking_fields.dart';
import '../booking_option_sheet.dart';

class BookingEventStage extends GetView<ClientBookingController> {
  const BookingEventStage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Icon(
                FIcons.notebookText,
                size: 64,
                color: context.fTheme.colors.mutedForeground,
              ),
              const SizedBox(height: 12),
              Text(
                'booking_stage_event_title'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                'booking_stage_event_subtitle'.tr,
                textAlign: TextAlign.center,
                style: context.typography.base.copyWith(
                  color: context.fTheme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Obx(
          () => BookingSelectField(
            label: 'booking_event_type'.tr,
            value: controller.selectedEventType.value.isEmpty
                ? ''
                : controller.selectedEventType.value.tr,
            placeholder: 'booking_event_type_placeholder'.tr,
            onTap: () => _showOptions(
              title: 'booking_event_type'.tr,
              options: controller.eventTypes,
              selectedValue: controller.selectedEventType.value,
              onSelect: controller.selectEventType,
              labelBuilder: (value) => value.tr,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => controller.shouldShowCustomEvent
              ? BookingTextField(
                  label: 'booking_event_custom'.tr,
                  hint: 'booking_event_custom_placeholder'.tr,
                  controller: controller.customEventController,
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(height: 12),
        BookingTextField(
          label: 'booking_note_optional'.tr,
          hint: 'booking_note_placeholder'.tr,
          controller: controller.noteController,
          maxLines: 2,
        ),
      ],
    );
  }

  void _showOptions({
    required String title,
    required List<String> options,
    required String selectedValue,
    required ValueChanged<String> onSelect,
    String Function(String value)? labelBuilder,
  }) {
    if (options.isEmpty) return;
    Get.bottomSheet(
      BookingOptionSheet(
        title: title,
        options: options,
        selectedValue: selectedValue,
        onSelect: onSelect,
        labelBuilder: labelBuilder,
      ),
      isScrollControlled: true,
    );
  }
}
