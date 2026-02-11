import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/booking/controller.dart';
import 'booking_stage_navigation.dart';
import 'stage_content.dart';

class BookingForm extends GetView<ClientBookingController> {
  const BookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookingStageContent(stage: controller.currentStage.value),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BookingStageNavigation(
              isFirstStage: controller.isFirstStage,
              isLastStage: controller.isLastStage,
              isSubmitting: controller.isSubmitting.value,
              onBack: () => Get.back(),
              onPrevious: controller.previousStage,
              onNext: controller.nextStage,
              onStartOver: controller.startOver,
              onSubmit: controller.submitBooking,
            ),
          ),
        ],
      );
    });
  }
}
