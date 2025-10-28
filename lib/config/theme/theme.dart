import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1A237E);
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: Colors.white70,
        surface: Color(0xFF1A237E),
        onSurface: Colors.white,
      ),

      //app bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1A237E),
        elevation: 0,
      ),

      //scaffold background color
      scaffoldBackgroundColor: const Color(0xFF0D1344),
      //card theme
      cardTheme: CardThemeData(
        color: const Color(0xFF1A237E),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      //tab bar theme
      tabBarTheme: const TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        indicatorColor: Colors.white,
      ),
      //floating action button theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF1A237E),
      ),
    );
  }
}
