import 'package:sukientotapp/core/services/localstorage_service.dart';
import 'package:sukientotapp/core/utils/logger.dart';
import 'package:sukientotapp/data/models/settings_model.dart';
import 'package:sukientotapp/data/providers/settings_provider.dart';
import 'package:sukientotapp/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsProvider _settingsProvider;

  SettingsRepositoryImpl(this._settingsProvider);

  @override
  Future<SettingsModel> fetchSettings() async {
    try {
      final response = await _settingsProvider.fetchSettings();
      final settings = SettingsModel.fromJson(response);

      StorageService.writeMapData(
        key: LocalStorageKeys.settings,
        value: settings.toJson(),
      );

      logger.i('[SettingsRepositoryImpl] [fetchSettings] Settings saved to storage');
      return settings;
    } catch (e) {
      logger.e('[SettingsRepositoryImpl] [fetchSettings] Failed: $e');
      rethrow;
    }
  }
}
