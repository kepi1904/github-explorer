import 'package:flutter/material.dart';

/// Class tema aplikasi GitHub Explorer
class AppTheme {
  static const Color primaryColor = Color(0xFF4DB6AC);
  static const Color primaryDark = Color(0xFF009688);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color borderColor = Color(0xFFE8E8E8);
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF8C8C8C);
  static const Color starColor = Color(0xFFFFA726);
  static const Color yellowSoftColor = Color(0xFFFEF7E8);
  static const Color levelColor = Color(0xFFE8A505);
  static const Color forkColor = Color(0xFF42A5F5);
  static const Color darkblueColor = Color(0xFF2657D1);
  static const Color avaBgColor = Color(0xFFF8D79A);
  static const Color blueSoft = Color(0xFF5AC5C5);
  static const Color errorColor = Color(0xFFE57373);
  static const Color successColor = Color(0xFF66BB6A);
  static const Color updateHere = Color(0xFFBEBEBE);

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      surface: surfaceColor,
      error: errorColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: textPrimary),
    ),
    cardTheme: CardThemeData(
      color: surfaceColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      hintStyle: const TextStyle(color: textSecondary, fontSize: 14),
      border: _border(borderColor),
      enabledBorder: _border(borderColor),
      focusedBorder: _border(primaryColor, 2),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static OutlineInputBorder _border(Color c, [double w = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: c, width: w),
      );
}
