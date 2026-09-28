import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Three visual modes:
///  • light  – bright white theme
///  • dark   – deep-space dark theme (default)
///  • study  – warm amber-tinted "night-light" / study mode (easy on eyes)
enum AppThemeMode { light, dark, study }

class ThemeProvider extends ChangeNotifier {
  AppThemeMode _mode = AppThemeMode.dark;

  AppThemeMode get mode => _mode;
  bool get isDark => _mode == AppThemeMode.dark;
  bool get isLight => _mode == AppThemeMode.light;
  bool get isStudy => _mode == AppThemeMode.study;

  /// Expose a standard ThemeMode for MaterialApp
  ThemeMode get themeMode {
    if (_mode == AppThemeMode.light) return ThemeMode.light;
    return ThemeMode.dark; // dark & study both use dark base
  }

  // ── study-mode colours ────────────────────────────────────────────────────
  static const Color studyBg     = Color(0xFF1A1400);  // deep amber-black
  static const Color studySurface = Color(0xFF2A2000); // warm card surface
  static const Color studyAccent = Color(0xFFFFD600);  // gold accent
  static const Color studyText   = Color(0xFFFFF3CD);  // warm white

  ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1565C0),
      brightness: Brightness.light,
    ),
    cardColor: Colors.white,
    scaffoldBackgroundColor: const Color(0xFFF5F7FA),
  );

  ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1565C0),
      brightness: Brightness.dark,
    ).copyWith(surface: const Color(0xFF0D1B2A)),
    scaffoldBackgroundColor: const Color(0xFF071320),
    cardColor: const Color(0xFF0D1B2A),
  );

  ThemeData get studyTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFFD600),
      brightness: Brightness.dark,
    ).copyWith(
      surface: studySurface,
      primary: studyAccent,
      onPrimary: Colors.black,
    ),
    scaffoldBackgroundColor: studyBg,
    cardColor: studySurface,
    textTheme: ThemeData.dark().textTheme.apply(bodyColor: studyText, displayColor: studyText),
  );

  ThemeData get currentTheme {
    switch (_mode) {
      case AppThemeMode.light:
        return lightTheme;
      case AppThemeMode.study:
        return studyTheme;
      default:
        return darkTheme;
    }
  }

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('appThemeMode') ?? 'dark';
    _mode = AppThemeMode.values.firstWhere(
      (e) => e.name == saved,
      orElse: () => AppThemeMode.dark,
    );
    notifyListeners();
  }

  Future<void> cycleTheme() async {
    // Cycle: dark → light → study → dark
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

  /// Legacy toggle (dark ↔ light) kept for compatibility
  Future<void> toggleTheme() async {
    _mode = (_mode == AppThemeMode.dark) ? AppThemeMode.light : AppThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('appThemeMode', _mode.name);
    notifyListeners();
  }
}
