import 'package:flutter/material.dart';
import 'package:tempo_zen/src/settings/theme/settings_service.dart';

class SettingsController extends ChangeNotifier{
  SettingsController(this._settingsService);

  final SettingsService _settingsService;

  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    await _settingsService.updateThemeMode(themeMode);
    notifyListeners();
  }
}