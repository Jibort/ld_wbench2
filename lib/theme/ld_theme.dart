// lib/theme/ld_theme.dart

import 'package:flutter/material.dart';

class LdTheme {
  // Colors constants per a referència
  static const Color primaryLight = Color(0xFF2196F3);    // Blau
  static const Color primaryDark = Color(0xFF1565C0);     // Blau fosc
  
  static const Color secondaryLight = Color(0xFFFF9800);  // Taronja
  static const Color secondaryDark = Color(0xFFFF5722);   // Taronja fosc
  
  static const Color backgroundLight = Color(0xFFF5F5F5); // Gris molt clar
  static const Color backgroundDark = Color(0xFF121212);  // Gris molt fosc
  
  static const Color surfaceLight = Color(0xFFFFFFFF);    // Blanc
  static const Color surfaceDark = Color(0xFF1E1E1E);     // Gris fosc
  
  static const Color errorLight = Color(0xFFB00020);      // Vermell
  static const Color errorDark = Color(0xFFCF6679);       // Rosa vermellós
  
  // Tema clar
  static ThemeData lightTheme = ThemeData.light().copyWith(
    // Esquema de colors principals
    colorScheme: ColorScheme.light(
      primary: primaryLight,
      onPrimary: Colors.white,
      secondary: secondaryLight,
      onSecondary: Colors.black,
      // background: backgroundLight,
      // onBackground: Colors.black87,
      surface: surfaceLight,
      onSurface: Colors.black87,
      error: errorLight,
      onError: Colors.white,
    ),
    
    // Colors específics per a components
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardTheme(
      color: surfaceLight,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLight,
        foregroundColor: Colors.white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryLight, width: 2),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(<Color>(states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return Colors.grey.shade400;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryLight,
      linearTrackColor: Colors.grey.shade200,
    ),
  );

  // Tema fosc
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    // Esquema de colors principals
    colorScheme: ColorScheme.dark(
      primary: primaryDark,
      onPrimary: Colors.white,
      secondary: secondaryDark,
      onSecondary: Colors.white,
      // background: backgroundDark,
      // onBackground: Colors.white,
      surface: surfaceDark,
      onSurface: Colors.white,
      error: errorDark,
      onError: Colors.black,
    ),
    
    // Colors específics per a components
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardTheme(
      color: surfaceDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryDark,
        foregroundColor: Colors.white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryDark,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color(0xFF2C2C2C), // Un gris fosc per als inputs
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryDark, width: 2),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return Colors.grey.shade700;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryDark,
      linearTrackColor: Colors.grey.shade800,
    ),
  );
}