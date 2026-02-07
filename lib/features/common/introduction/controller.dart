import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/introduction/step_images.dart';

class IntroductionController extends GetxController {
  var userType = Get.arguments['isServiceProvider'] as bool? ?? false;
  RxBool isServiceProvider = false.obs;
  final int maxStep = 2;

  /// starts at 0 because [introductionImages] is a [List]
  RxInt currentStep = RxInt(0);

  /// dynamically update from 'next' to 'start'
  /// when the user is on the last intro step
  RxString nextButtonText = RxString('next'.tr);

  /// big intro text, dynamically updated by [_syncIntroText]
  RxString introTextKey = RxString('');

  @override
  void onInit() {
    super.onInit();
    isServiceProvider.value = userType;
    _syncIntroText(currentStep.value);
  }

  void nextStep() {
    toStep(currentStep.value + 1);
  }

  void prevStep() {
    toStep(currentStep.value - 1);
  }

  void toStep(int step) {
    if (step <= -1) {
      currentStep.value = 0;
      return;
    }
    if (step > maxStep) {
      currentStep.value = maxStep;
      exitIntro();
      return;
    }
    // final step changes the text to 'start'
    if (step == maxStep) {
      nextButtonText.value = 'start_now'.tr;
    }
    if (step < maxStep) {
      nextButtonText.value = 'next'.tr;
    }
    currentStep.value = step;
    _syncIntroText(currentStep.value);
    logger.d('going to step ${currentStep.value + 1}');
  }

  void exitIntro() {
    Get.offNamed(
      Routes.guestHomeScreen,
      arguments: {'isServiceProvider': isServiceProvider.value},
    );
  }

  /// update value states for every step
  void _syncIntroText(int step) {
    introTextKey.value = IntroductionStepImages.getIntroTextKey(
      isServiceProvider: isServiceProvider.value,
      step: step,
    );
  }
}
