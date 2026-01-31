import 'package:sukientotapp/core/utils/import/global.dart';
import 'language_switch_controller.dart';

class LanguageSwitch extends StatelessWidget {
  LanguageSwitch({super.key});

  final LanguageSwitchController controller = Get.isRegistered<LanguageSwitchController>()
      ? Get.find<LanguageSwitchController>()
      : Get.put(LanguageSwitchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final label = controller.locale.value.languageCode.toUpperCase();
      return GestureDetector(
        onTap: controller.toggle,
        child: Container(
          width: 30,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: FTheme.of(context).colors.primary.withValues(alpha: 0.9),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      );
    });
  }
}
