import 'package:flutter/material.dart';
import 'package:motion/motion.dart';
import 'package:tempo_zen/services/notifi_services.dart';
import 'package:tempo_zen/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Notification Service
  NotificationService().init();

  /// Initialize the plugin to determine gyroscope availability.
  await Motion.instance.initialize();

  /// Globally set Motion's update interval to 60 frames per second.
  Motion.instance.setUpdateInterval(60.fps);

  runApp(const MyApp());
}
