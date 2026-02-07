import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/introduction/controller.dart';
import 'widget/widgets.dart';

class IntroductionScreen extends GetView<IntroductionController> {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      childPad: false,
      child: Obx(
        () => Stack(
          children: [
            IntroBackground(controller: controller),
            const IntroTopGradient(),
            IntroContent(controller: controller),
            const IntroBottomGradient(),
            IntroButtons(controller: controller),
          ],
        ),
      ),
    );
  }
}
