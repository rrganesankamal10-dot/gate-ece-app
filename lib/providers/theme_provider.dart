import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Three visual modes:
///  â€¢ light  â€“ bright white theme
///  â€¢ dark   â€“ deep-space dark theme (default)
///  â€¢ study  â€“ warm amber-tinted "night-light" / study mode (easy on eyes)
enum AppThemeMode { light, dark, study }

class ThemeProvider extends ChangeNotifier {
  AppThemeMode _mode = AppThemeMode.light;

  AppThemeMode get mode => _mode;
  bool get isDark  => _mode == AppThemeMode.dark;
  bool get isLight => _mode == AppThemeMode.light;
  bool get isStudy => _mode == AppThemeMode.study;

  /// Expose a standard ThemeMode for MaterialApp
  ThemeMode get themeMode {
    if (_mode == AppThemeMode.light) return ThemeMode.light;
    return ThemeMode.dark; // dark & study both use dark base
  }

  // â”€â”€ study-mode colour constants â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static const Color studyBg      = Color(0xFF1A1400);   // deep amber-black
  static const Color studySurface = Color(0xFF2A2000);   // warm card surface
  static const Color studyAccent  = Color(0xFFFFD600);   // gold accent
  static const Color studyText    = Color(0xFFFFF3CD);   // warm white

  // â”€â”€ simple ThemeData helpers (used by main.dart) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
      );

  ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.dark,
        ).copyWith(surface: const Color(0xFF0D1B2A)),
        scaffoldBackgroundColor: const Color(0xFF071320),
      );

  ThemeData get studyTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: studyAccent,
          brightness: Brightness.dark,
        ).copyWith(
          surface: studySurface,
          primary: studyAccent,
          onPrimary: Colors.black,
        ),
        scaffoldBackgroundColor: studyBg,
      );

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved  = prefs.getString('appThemeMode') ?? 'light';
    _mode = AppThemeMode.values.firstWhere(
      (e) => e.name == saved,
      orElse: () => AppThemeMode.light,
    );
    notifyListeners();
  }

  /// Cycle: dark â†’ light â†’ study â†’ dark
  Future<void> cycleTheme() async {
    switch (_mode) {
      case AppThemeMode.dark:
        _mode = AppThemeMode.light;
        break;
      case AppThemeMode.light:
        _mode = AppThemeMode.study;
        break;
      case AppThemeMode.study:
        _mode = AppThemeMode.dark;
        break;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('appThemeMode', _mode.name);
    notifyListeners();
  }

  /// Legacy toggle (dark â†” light) kept for compatibility
  Future<void> toggleTheme() async {
    _mode = (_mode == AppThemeMode.dark) ? AppThemeMode.light : AppThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('appThemeMode', _mode.name);
    notifyListeners();
  }
}
