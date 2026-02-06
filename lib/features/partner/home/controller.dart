import 'package:sukientotapp/core/utils/import/global.dart';

class HomeController extends GetxController {
  RxString name = (StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'name') ?? '')
      .toString()
      .obs;
  RxString avatar =
      (StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'avatar_url') ?? '')
          .toString()
          .obs;
}
