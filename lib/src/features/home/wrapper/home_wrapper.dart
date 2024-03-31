import 'package:flutter/material.dart';
import 'package:tempo_zen/src/features/home/screen/mobile_home_screen.dart';
import 'package:tempo_zen/src/features/home/screen/web_home_screen.dart';
import 'package:tempo_zen/src/settings/theme/settings_controller.dart';

class HomeWrapper extends StatelessWidget {
  final SettingsController controller;
  static const String routeName = '/';

  const HomeWrapper({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 870) {
        return MobileHomeScreen(
          controller: controller,
        );
      }
      return const WebHomeScreen();
    });
  }
}
