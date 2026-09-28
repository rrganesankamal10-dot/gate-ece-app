import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/theme_provider.dart';
import 'providers/progress_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
      ],
      child: const GateEceMasterApp(),
    ),
  );
}

class GateEceMasterApp extends StatelessWidget {
  const GateEceMasterApp({super.key});

  // ── shared card shape ──────────────────────────────────────────────────
  static CardThemeData _cardTheme(Color? color, double elevation) => CardThemeData(
        color: color,
        elevation: elevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      );

  // ── shared button style ────────────────────────────────────────────────
  static ElevatedButtonThemeData _buttonTheme(Color bg) => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      );

  // ── shared appbar theme ────────────────────────────────────────────────
  static AppBarTheme _appBarTheme(Color bg, Color fg) => AppBarTheme(
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: fg,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      );

  // ── Light theme ────────────────────────────────────────────────────────
  ThemeData _lightTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D47A1),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        appBarTheme: _appBarTheme(const Color(0xFF0D47A1), Colors.white),
        cardTheme: _cardTheme(null, 3),
        elevatedButtonTheme: _buttonTheme(const Color(0xFF0D47A1)),
      );

  // ── Dark theme ─────────────────────────────────────────────────────────
  ThemeData _darkTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.dark,
        ).copyWith(surface: const Color(0xFF0D1B2A)),
        scaffoldBackgroundColor: const Color(0xFF071320),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        appBarTheme: _appBarTheme(const Color(0xFF0D1B2A), Colors.white),
        cardTheme: _cardTheme(const Color(0xFF162032), 4),
        elevatedButtonTheme: _buttonTheme(const Color(0xFF1565C0)),
      );

  // ── Study / Night-light theme ──────────────────────────────────────────
  ThemeData _studyTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD600),
          brightness: Brightness.dark,
        ).copyWith(
          surface: ThemeProvider.studySurface,
          primary: ThemeProvider.studyAccent,
          onPrimary: Colors.black,
        ),
        scaffoldBackgroundColor: ThemeProvider.studyBg,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme)
            .apply(bodyColor: ThemeProvider.studyText, displayColor: ThemeProvider.studyText),
        appBarTheme: _appBarTheme(ThemeProvider.studyBg, ThemeProvider.studyText),
        cardTheme: _cardTheme(ThemeProvider.studySurface, 4),
        elevatedButtonTheme: _buttonTheme(ThemeProvider.studyAccent),
      );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'GATE ECE Master',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: _lightTheme(),
      darkTheme: themeProvider.isStudy ? _studyTheme() : _darkTheme(),
      home: const SplashScreen(),
    );
  }
}
