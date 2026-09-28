import 'package:flutter/material.dart';

class AppTheme {
  static const Color bgDark = Color(0xFF0A0E17);
  static const Color cardDark = Color(0xFF141A29);
  static const Color neonCyan = Color(0xFF00E5FF);
  static const Color neonPurple = Color(0xFF7C4DFF);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgDark,
        colorScheme: const ColorScheme.dark(
          primary: neonCyan,
          secondary: neonPurple,
          surface: cardDark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: cardDark,
          selectedItemColor: neonCyan,
          unselectedItemColor: textSecondary,
          type: BottomNavigationBarType.fixed,
        ),
        cardTheme: CardTheme(
          color: cardDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: cardDark,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      );
}