import 'package:sukientotapp/core/utils/import/global.dart';
import 'dev_list_tile.dart';

class ClearStorageItem extends StatelessWidget {
  const ClearStorageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return DevListTile(
      icon: Icons.delete_outline,
      title: 'Clear Local Storage',
      onTap: () async {
        StorageService.clearAllData();
        Get.snackbar('Success', 'Storage cleared');
        Get.back();
      },
    );
  }
}
