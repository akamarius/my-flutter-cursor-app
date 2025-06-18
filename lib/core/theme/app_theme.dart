import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFFC6DCF8);
  static const Color lightAzure = Color(0xFFF0FFFF);
  static const Color white = Color(0xFFFFFFFF);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: white,
      colorScheme: const ColorScheme.light(
        primary: primaryBlue,
        secondary: lightAzure,
        surface: white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlue,
        elevation: 0,
      ),
    );
  }
}
