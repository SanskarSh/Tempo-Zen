import 'package:flutter/material.dart';
import 'package:tempo_zen/src/features/home/screen/mobile_home_screen.dart';
import 'package:tempo_zen/src/features/home/screen/web_home_screen.dart';

class HomeWrapper extends StatelessWidget {
  static const String routeName = '/';

  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 670) {
        return const MobileHomeScreen();
      }
      return const WebHomeScreen();
    });
  }
}
