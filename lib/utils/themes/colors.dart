import 'package:flutter/material.dart';

class AppColors {
  static Color primaryBlue = const Color(0xff22577a);
  static Color primaryBlue70 = const Color(0xff22577a).withOpacity(0.7);

  static MaterialColor primarySwatch =
      MaterialColor(AppColors.primaryBlue.value, {
    50: const Color(0xFFE4EBEF),
    100: const Color(0xFFBDCDD7),
    200: const Color(0xFF91ABBD),
    300: const Color(0xFF6489A2),
    400: const Color(0xFF43708E),
    500: AppColors.primaryBlue,
    600: const Color(0xFF1E4F72),
    700: const Color(0xFF194667),
    800: const Color(0xFF143C5D),
    900: const Color(0xFF0C2C4A),
  });

  static ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryBlue,
    onPrimary: Colors.white,
    secondary: Colors.lightGreen,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.blue,
    surface: Colors.white70,
    onSurface: Colors.black,
  );
}
