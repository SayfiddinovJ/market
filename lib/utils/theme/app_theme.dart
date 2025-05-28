import 'package:flutter/material.dart';

class AppTheme {
  static final Color primaryColor = Colors.blue;

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(color: Colors.black87, fontSize: 14),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF121212),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(color: Colors.white70, fontSize: 14),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
    ).copyWith(secondary: primaryColor),
  );
}
