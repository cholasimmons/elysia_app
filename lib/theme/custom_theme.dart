import 'package:elysia_app/theme/palette.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.purple300,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'ElysiaFont',
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'ElysiaFont',
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'ElysiaFont',
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontFamily: 'ElysiaFont',
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      // Add more styles as needed
    ),
    // Customize other theme properties here
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: Palette.purple700, brightness: Brightness.dark),
    useMaterial3: true,
    // Customize other theme properties here
  );
}
