import 'package:flutter/material.dart';

final theme = ThemeData.from(
  textTheme: TextTheme(
    headline3: const TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    headline4: TextStyle(
      color: Colors.amber.shade600,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    headline5: TextStyle(
      color: Colors.amber.shade600,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: const TextStyle(fontSize: 16, color: Colors.red),
    subtitle2: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.red,
    onPrimary: Colors.white,
    secondary: Colors.amber,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: Color.fromARGB(255, 235, 235, 235),
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
);
