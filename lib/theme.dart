import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const primaryColor = 0XFF672CBC;
  static const titleColor = 0XFF240F4F;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    primaryColor: const Color(primaryColor),
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'OpenSans',
    colorScheme: const ColorScheme.light(
        primary: Color(primaryColor),
        onPrimary: Color(primaryColor),
        secondary: Color(titleColor)),
    iconTheme: const IconThemeData(color: Colors.black38),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Color(0XFF8789A3),
      iconTheme: IconThemeData(
        color: Colors.black38,
      ),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: Color(primaryColor),
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color(primaryColor)),
      bodyLarge: TextStyle(color: Color(titleColor)),
      bodyMedium: TextStyle(color: Colors.black87),
      bodySmall: TextStyle(color: Colors.grey),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Color(titleColor),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    primaryColor: Colors.white,
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: const Color(0XFF272948),
    fontFamily: 'OpenSans',
    colorScheme: const ColorScheme.light(
        primary: Color(primaryColor),
        onPrimary: Color(primaryColor),
        secondary: Color(titleColor)),
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(0XFF272948),
      foregroundColor: Color(0XFF8789A3),
      iconTheme: IconThemeData(
        color: Colors.white54,
      ),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0XFF272948),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      bodySmall: TextStyle(color: Colors.grey),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white70,
      iconColor: Colors.white,
    ),
    dividerColor: Colors.white,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0XFF272948),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.white70,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white70,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
    ),
  );
}
