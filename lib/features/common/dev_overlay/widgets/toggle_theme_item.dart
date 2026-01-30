import 'package:sukientotapp/core/utils/import/global.dart';
import 'dev_list_tile.dart';

class ToggleThemeItem extends StatelessWidget {
  const ToggleThemeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return DevListTile(
      icon: Icons.palette_outlined,
      title: 'Toggle Theme',
      onTap: () {
        if (Get.isDarkMode) {
          Get.changeThemeMode(ThemeMode.light);
        } else {
          Get.changeThemeMode(ThemeMode.dark);
        }
        Get.back();
      },
    );
  }
}
