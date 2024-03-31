import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tempo_zen/src/features/error/screen/error_screen.dart';
import 'package:tempo_zen/src/features/home/wrapper/home_wrapper.dart';
import 'package:tempo_zen/src/settings/theme/settings_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tempo_zen/src/settings/theme/theme.dart';

class MyApp extends StatelessWidget {
  final SettingsController controller;

  const MyApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      builder: (context, Widget? child) {
        return MaterialApp(
          /// The [onGenerateTitle] callback is called when the app is started.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          /// The [themeMode] is used to set the theme mode of the app.
          themeMode: controller.themeMode,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,

          // localizationsDelegates: AppLocalizations.localizationsDelegates,
          // supportedLocales: AppLocalizations.supportedLocales,

          /// The [localizationsDelegates] are used to localize the app.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          /// The [supportedLocales] are the locales that the app supports.
          supportedLocales: const [
            Locale('en'), // English
            // Locale('es'), // ToDo Spanish
          ],

          /// The [restorationScopeId] is used to save and restore the state of the app.
          restorationScopeId: "/home",

          /// The [onGenerateRoute] callback is called when the app is navigated to a named route.
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (BuildContext context) {
                switch (settings.name) {
                  case HomeWrapper.routeName:
                    return HomeWrapper(
                      controller: controller,
                    );
                  default:
                    return const ErrorScreen();
                }
              },
            );
          },
        );
      },
      listenable: controller,
    );
  }
}
