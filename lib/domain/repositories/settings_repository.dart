import 'package:sukientotapp/data/models/settings_model.dart';

abstract class SettingsRepository {
  Future<SettingsModel> fetchSettings();
}
