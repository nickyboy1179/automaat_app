import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    onSurface: Colors.purple.shade400,
    primary: Colors.purple.shade400,
    onPrimary: Colors.white,
    secondary: Colors.purple.shade100,
    onSecondary: Colors.white54,

    // For no network buttons
    tertiary: Colors.grey.shade600,
    onTertiary: Colors.grey.shade300,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent background
      statusBarIconBrightness: Brightness.dark, // Dark icons for light mode
    ),
  )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    onSurface: Colors.white,
    primary: Colors.white,
    onPrimary: Colors.grey.shade900,
    secondary: Colors.purple.shade400,
    onSecondary: Colors.grey.shade900,

    // For no network buttons

    tertiary: Colors.grey.shade600,
    onTertiary: Colors.grey.shade300,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent background
      statusBarIconBrightness: Brightness.light, // Dark icons for light mode
    ),
  )
);