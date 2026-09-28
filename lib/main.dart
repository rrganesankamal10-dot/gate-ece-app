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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Use the ThemeProvider's computed themes for all 3 modes
    return MaterialApp(
      title: 'GATE ECE Master',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: themeProvider.lightTheme.copyWith(
        textTheme: GoogleFonts.interTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF0D47A1),
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D47A1),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
      ),
      darkTheme: themeProvider.isStudy
          ? themeProvider.studyTheme.copyWith(
              textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme)
                  .apply(bodyColor: ThemeProvider.studyText, displayColor: ThemeProvider.studyText),
              appBarTheme: AppBarTheme(
                backgroundColor: ThemeProvider.studyBg,
                foregroundColor: ThemeProvider.studyText,
                elevation: 0,
                titleTextStyle: GoogleFonts.inter(
                  color: ThemeProvider.studyText,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              cardTheme: CardTheme(
                color: ThemeProvider.studySurface,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
            )
          : themeProvider.darkTheme.copyWith(
              textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
              appBarTheme: AppBarTheme(
                backgroundColor: const Color(0xFF0D1B2A),
                foregroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              cardTheme: CardTheme(
                color: const Color(0xFF162032),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
              ),
            ),
      home: const SplashScreen(),
    );
  }
}
