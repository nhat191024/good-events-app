import 'package:sukientotapp/core/utils/import/global.dart';

class LanguageSwitchController extends GetxController {
  final locale = Rx<Locale>(Get.locale ?? const Locale('vi', 'VN'));

  @override
  void onInit() {
    super.onInit();
    final saved = StorageService.readMapData(key: LocalStorageKeys.locale);
    if (saved is Map<String, dynamic>) {
      final code = (saved['languageCode'] ?? 'vi') as String;
      final country = (saved['countryCode'] ?? (code == 'vi' ? 'VN' : 'US')) as String;
      locale.value = Locale(code, country);
      Get.updateLocale(locale.value);
    }
  }

  void toggle() {
    final newLocale = locale.value.languageCode == 'vi'
        ? const Locale('en', 'US')
        : const Locale('vi', 'VN');
    locale.value = newLocale;
    Get.updateLocale(newLocale);

    StorageService.writeMapData(
      key: LocalStorageKeys.locale,
      value: {'languageCode': newLocale.languageCode, 'countryCode': newLocale.countryCode},
    );
  }
}
