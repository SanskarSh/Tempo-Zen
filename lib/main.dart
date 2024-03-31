import 'package:flutter/material.dart';
import 'package:tempo_zen/services/notifi_services.dart';
import 'package:tempo_zen/src/app.dart';
import 'package:tempo_zen/src/settings/theme/settings_controller.dart';
import 'package:tempo_zen/src/settings/theme/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(MyApp(controller: settingsController));
}
