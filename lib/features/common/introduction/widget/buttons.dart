import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/introduction/controller.dart';
import 'package:sukientotapp/features/components/button/plus.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IntroButtons extends StatelessWidget {
  final IntroductionController controller;

  /// skip and next/start btn
  const IntroButtons({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButtonPlus(
                btnText: 'skip'.tr,
                onTap: () => controller.exitIntro(),
                width: kDebugMode ? (Get.width * 0.1) : (Get.width * 0.4),
                color: const Color.fromARGB(0, 255, 255, 255),
                textColor: AppColors.white,
                borderColor: const Color.fromARGB(0, 245, 159, 11),
              ).animate(
                effects: [
                  SlideEffect(
                    begin: Offset(0, 3),
                    curve: ElasticInOutCurve(),
                    end: Offset(0, 0),
                    duration: Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 100),
                  ),
                ],
              ),
              if (kDebugMode)
                CustomButtonPlus(
                  btnText: 'previous'.tr,
                  onTap: () => controller.prevStep(),
                  width: Get.width * 0.1,
                  color: Colors.white,
                  textColor: AppColors.primary,
                  borderColor: AppColors.primary,
                ).animate(
                  effects: [
                    SlideEffect(
                      begin: Offset(0, 3),
                      curve: ElasticInOutCurve(),
                      end: Offset(0, 0),
                      duration: Duration(milliseconds: 500),
                      delay: Duration(milliseconds: 50),
                    ),
                  ],
                ),
              CustomButtonPlus(
                btnText: controller.nextButtonText.value,
                onTap: () => controller.nextStep(),
                width: Get.width * 0.4,
                color: AppColors.amber500,
                borderColor: AppColors.amber500,
              ).animate(
                effects: [
                  SlideEffect(
                    begin: Offset(0, 3),
                    curve: ElasticInOutCurve(),
                    end: Offset(0, 0),
                    duration: Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
