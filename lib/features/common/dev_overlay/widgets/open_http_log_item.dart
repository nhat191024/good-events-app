import 'package:dio_log/dio_log.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'dev_list_tile.dart';

class OpenHttpLogItem extends StatelessWidget {
  const OpenHttpLogItem({super.key});

  @override
  Widget build(BuildContext context) {
    return DevListTile(
      icon: Icons.wifi_tethering_outlined,
      title: 'Open HTTP Log',
      onTap: () {
        Get.back();
        Get.to(() => HttpLogListWidget());
      },
    );
  }
}