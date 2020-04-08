import 'package:flutter/material.dart';

final ThemeData BandoThemeData = new ThemeData(
  fontFamily: 'Montserrat',
  brightness: Brightness.light,
  primarySwatch: MaterialColor(BandoColors.blue[50].value, BandoColors.blue),
  primaryColor: BandoColors.blue[500],
  primaryColorBrightness: Brightness.light,
  accentColor: BandoColors.green[500],
  accentColorBrightness: Brightness.light
);

class BandoColors {
  BandoColors._(); // this basically makes it so you can instantiate this class
  static const Map<int, Color> green = const <int, Color> {
    50: const Color(0xFF131710),
    100: const Color(0xFF3A452F),
    200: const Color(0xFF3A452F),
    300: const Color(0xFF88A06D),
    400: const Color(0xFFAFCE8C),
    500: const Color(0xFFC2E59C),
    600: const Color(0xFFC8E8A6),
    700: const Color(0xFFD4EDBA),
    800: const Color(0xFFE1F2CE),
    900: const Color(0xFFEDF7E1),
    1000: const Color(0xFFF9FCF5)
  };

  static const Map<int, Color> blue = const <int, Color> {
    50: const Color(0xFF0A1218),
    100: const Color(0xFF1E3649),
    200: const Color(0xFF325A7A),
    300: const Color(0xFF467DAB),
    400: const Color(0xFF5AA1DC),
    500: const Color(0xFF64B3F4),
    600: const Color(0xFF74BBF5),
    700: const Color(0xFF93CAF7),
    800: const Color(0xFFB2D9FA),
    900: const Color(0xFFD1E8FC),
    1000: const Color(0xFFF0F7FE)
  };
}