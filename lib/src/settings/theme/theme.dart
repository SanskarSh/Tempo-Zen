import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      background: Color(0XFFE5E5E5),
      primary: Color(0XFF0E0F11),
      secondary: Colors.greenAccent,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      background: Color(0XFF0E0F11),
      primary: Color(0XFFE5E5E5),
      // secondary: Color.fromRGBO(85, 95, 124, 1),
      secondary: Colors.greenAccent,
    ),
  );
}
