import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand
  static const Color primary = Color(0xFF00C853);
  static const Color primaryDark = Color(0xFF009624);
  static const Color secondary = Color(0xFF00B0FF);
  static const Color accent = Color(0xFFFFD600);

  // Game UI
  static const Color hpRed = Color(0xFFE53935);
  static const Color energyYellow = Color(0xFFFFD600);
  static const Color coinGold = Color(0xFFFFC107);
  static const Color pointsGreen = Color(0xFF4CAF50);

  // Background
  static const Color darkBg = Color(0xFF0A1628);
  static const Color cardDark = Color(0xFF112240);
  static const Color surfaceDark = Color(0xFF1A2F4A);

  // Monster rarities
  static const Color rarityCommon = Color(0xFF9E9E9E);
  static const Color rarityUncommon = Color(0xFF4CAF50);
  static const Color rarityRare = Color(0xFF2196F3);
  static const Color rarityEpic = Color(0xFF9C27B0);
  static const Color rarityLegendary = Color(0xFFFF9800);
}

class AppTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surfaceDark,
          error: AppColors.hpRed,
        ),
        scaffoldBackgroundColor: AppColors.darkBg,
        cardTheme: CardThemeData(
          color: AppColors.cardDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF1E3A5F), width: 1),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBg,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(color: Color(0xFFB0BEC5), fontSize: 14),
        ),
      );
}
