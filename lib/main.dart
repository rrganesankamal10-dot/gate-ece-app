import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const GateEceApp());
}

class GateEceApp extends StatefulWidget {
  const GateEceApp({super.key});

  @override
  State<GateEceApp> createState() => _GateEceAppState();
}

class _GateEceAppState extends State<GateEceApp> {
  bool _isDark = false;
  static const _prefKey = 'is_dark_mode';

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _isDark = prefs.getBool(_prefKey) ?? false);
  }

  Future<void> _toggleTheme() async {
    setState(() => _isDark = !_isDark);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, _isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GATE ECE Companion',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(isDarkMode: _isDark, onToggleTheme: _toggleTheme),
    );
  }
}
