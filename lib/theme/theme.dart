import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    onSurface: Colors.purple.shade400,
    primary: Colors.white,
    onPrimary: Colors.purple.shade600,
    secondary: Colors.white,
    onSecondary: Colors.purple.shade200,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    onSurface: Colors.white,
    primary: Colors.grey.shade700,
    onPrimary: Colors.white,
    secondary: Colors.grey.shade500,
    onSecondary: Colors.white,
  ),
);