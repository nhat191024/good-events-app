import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/introduction/controller.dart';
import 'package:sukientotapp/features/components/common/language_switch/language_switch.dart';
import 'side-images/main.dart';
import 'text.dart';

class IntroContent extends StatelessWidget {
  final IntroductionController controller;

  /// main content, including lang switch
  const IntroContent({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(padding: const EdgeInsets.only(right: 10, top: 5), child: LanguageSwitch()),
            IntroText(controller: controller),
            IntroPeople(controller: controller),
          ],
        ),
      ),
    );
  }
}
