import 'package:flutter/material.dart';
import 'package:tempo_zen/src/settings/theme/settings_controller.dart';

class ToggleTheme extends StatefulWidget {
  const ToggleTheme({super.key, required this.controller});

  final SettingsController controller;

  @override
  State<ToggleTheme> createState() => _ToggleThemeState();
}

bool _switch = false;

class _ToggleThemeState extends State<ToggleTheme> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _switch = !_switch;
        widget.controller
            .updateThemeMode(_switch ? ThemeMode.dark : ThemeMode.light);
      },
      icon: _switch
          ? Icon(
              Icons.dark_mode,
              color: Theme.of(context).colorScheme.background,
            )
          : Icon(
              Icons.light_mode,
              color: Theme.of(context).colorScheme.background,
            ),
    );
  }
}
