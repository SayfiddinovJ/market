import 'package:flutter/material.dart';
import 'package:market/utils/extensions/extensions.dart';

class AppTheme {
  static final Color primaryColor = Colors.blue;

  static final ThemeData lightTheme = ThemeData(
    extensions: [ContainerColors(background: Colors.grey.shade200)],
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white.withValues(alpha: 0.5),
      foregroundColor: Colors.black,
      surfaceTintColor: Colors.white,
      elevation: 1,
      scrolledUnderElevation: 0,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    extensions: [ContainerColors(background: Colors.grey.shade800)],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black.withValues(alpha: 0.7),
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.black,
      elevation: 1,
      scrolledUnderElevation: 0,
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
  );
}
