import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/introduction/controller.dart';
import 'package:sukientotapp/features/common/introduction/step_images.dart';

import 'effects.dart';
import 'utils.dart';
import 'positions.dart';

class IntroPeople extends StatelessWidget {
  final IntroductionController controller;

  /// not actually 'people' all the time but it's the client/clown images
  /// and is animated
  const IntroPeople({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double imageHeight = constraints.maxHeight * 0.5;
          final int step = controller.currentStep.value;
          final bool isServiceProvider = controller.isServiceProvider.value;

          /// this only change the FIRST STEP animation.
          /// and won't turn off animations on the next steps
          final bool playAnimationOnPageLoad = true;

          /// image paths
          final String personAPath = IntroductionStepImages.getIntroImage(
            isServiceProvider: isServiceProvider,
            step: step,
            key: IntroImageKey.personA,
          );

          final String personBPath = IntroductionStepImages.getIntroImage(
            isServiceProvider: isServiceProvider,
            step: step,
            key: IntroImageKey.personB,
          );

          return Stack(
            children: [
              leftImage(
                playOnEnter: playAnimationOnPageLoad,
                path: personAPath,
                height: imageHeight,

                /// initial image position
                position: positionsForStep(
                  step,
                  isServiceProvider: isServiceProvider,
                ).left,

                /// animation image effects
                effects: effectsForStep(
                  step,
                  isLeft: true,
                  isServiceProvider: isServiceProvider,
                ),
                step: step,
              ),
              rightImage(
                playOnEnter: playAnimationOnPageLoad,
                path: personBPath,
                height: imageHeight,

                /// initial image position
                position: positionsForStep(
                  step,
                  isServiceProvider: isServiceProvider,
                ).right,

                /// animation image effects
                effects: effectsForStep(
                  step,
                  isLeft: false,
                  isServiceProvider: isServiceProvider,
                ),
                step: step,
              ),
            ],
          );
        },
      ),
    );
  }
}
