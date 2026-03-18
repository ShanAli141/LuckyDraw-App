import 'package:flutter/material.dart';

class AppTextStyles {
  static const String _fontFamily = 'Poppins';

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 1.2,
      letterSpacing: -0.5,
    ),
    displayMedium: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 26,
      fontWeight: FontWeight.w600,
      height: 1.25,
    ),
    titleLarge: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    titleMedium: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
    bodyLarge: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.4,
    ),
    bodyMedium: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.4,
    ),
    labelLarge: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
  );

  static TextTheme darkTextTheme = lightTextTheme;
}