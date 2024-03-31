import 'package:flutter/material.dart';

class SettingsService{
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    // ToDo Save the theme data in shared preferences
  }
}