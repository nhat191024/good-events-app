import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/introduction/controller.dart';
import 'package:sukientotapp/features/common/introduction/step_images.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IntroBackground extends StatelessWidget {
  final IntroductionController controller;

  /// bground
  const IntroBackground({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Image.asset(
              IntroductionStepImages.getIntroImage(
                isServiceProvider: controller.isServiceProvider.value,
                step: controller.currentStep.value,
                key: IntroImageKey.bg,
              ),
              fit: BoxFit.cover,
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .blur(
          begin: const Offset(6, 6),
          end: const Offset(0, 0),
          duration: 600.ms,
        );
  }
}
