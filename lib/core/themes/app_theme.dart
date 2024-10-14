import 'package:flutter/material.dart';
import 'package:news_app_test/core/constants/colors.dart';

class AppTheme {
// Light Theme
  final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: lightThemeBackgroundColor,
    brightness: Brightness.light,
    inputDecorationTheme: _inputDecorationTheme(Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // textStyle: AppFonts.cardTitle.copyWith(fontSize: 10),
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        disabledBackgroundColor: shadowColor,
        disabledForegroundColor: shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: const Size.fromHeight(50),
      ),
    ),
  );

// Dark Theme
  final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: darkThemeBackgroundColor,
    brightness: Brightness.dark,
    inputDecorationTheme: _inputDecorationTheme(Colors.black),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // textStyle: AppFonts.cardTitle.copyWith(fontSize: 10),
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        disabledBackgroundColor: shadowColor,
        disabledForegroundColor: shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: const Size.fromHeight(50),
      ),
    ),
  );
}

InputDecorationTheme _inputDecorationTheme(Color fillColor) {
  return InputDecorationTheme(
    filled: true,
    fillColor: fillColor,
    // labelStyle: AppFonts.labelText,
    border: _outlineInputBorder(),
    enabledBorder: _outlineInputBorder(),
    focusedBorder: _outlineInputBorder(),
    disabledBorder: _outlineInputBorder(),
    floatingLabelBehavior: FloatingLabelBehavior.always,
  );
}

OutlineInputBorder _outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: shadowColor, width: 0.5),
  );
}
