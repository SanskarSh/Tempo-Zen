import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tempo_zen/src/features/error/screen/error_screen.dart';
import 'package:tempo_zen/src/features/home/wrapper/home_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tempo_zen/src/settings/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// The [onGenerateTitle] callback is called when the app is started.
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,

      theme: MyTheme.lightTheme,

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
                return const HomeWrapper();
              default:
                return const ErrorScreen();
            }
          },
        );
      },
    );
  }
}
