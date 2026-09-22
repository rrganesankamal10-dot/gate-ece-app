import 'package:flutter/material.dart';

/// Central place for every color/typography choice in the app.
/// Keeping it here means the whole app updates from one file
/// instead of hunting through every screen.
class AppTheme {
  // Brand accent — used for buttons, highlights, progress rings.
  static const Color accent = Color(0xFF4C6FFF);
  static const Color accentSoft = Color(0xFFE8ECFF);

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF7F8FC),
    colorScheme: ColorScheme.fromSeed(
      seedColor: accent,
      brightness: Brightness.light,
    ),
    textTheme: _textTheme(const Color(0xFF1A1B25)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Color(0xFF1A1B25),
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: EdgeInsets.zero,
    ),
  );

  // Dark mode is tuned for low eye strain during night study sessions —
  // not pure black (harsh contrast), a soft charcoal instead.
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF14151C),
    colorScheme: ColorScheme.fromSeed(
      seedColor: accent,
      brightness: Brightness.dark,
    ),
    textTheme: _textTheme(const Color(0xFFEDEDF2)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Color(0xFFEDEDF2),
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: const Color(0xFF1E1F29),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: EdgeInsets.zero,
    ),
  );

  static TextTheme _textTheme(Color base) {
    return TextTheme(
      headlineMedium: TextStyle(fontWeight: FontWeight.w700, color: base, fontSize: 26),
      titleLarge: TextStyle(fontWeight: FontWeight.w600, color: base, fontSize: 20),
      titleMedium: TextStyle(fontWeight: FontWeight.w600, color: base, fontSize: 16),
      bodyLarge: TextStyle(color: base, fontSize: 15, height: 1.5),
      bodyMedium: TextStyle(color: base.withOpacity(0.75), fontSize: 14, height: 1.5),
    );
  }
}
