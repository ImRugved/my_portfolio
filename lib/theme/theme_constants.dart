import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConstants {
  static const primary = Color(0xFF0468d7);
  static const secondary = Color(0xFF022d63);
  static const accent = Color(0xFF05aff2);
  static const light = Color(0xFFf4f7ff);
  static const dark = Color(0xFF1a1a2e);
  static const success = Color(0xFF4caf50);
  static const text = Color(0xFF333333);
  static const textLight = Color(0xFF666666);
  static const background = Color(0xFFffffff);
  static const cardBg = Color(0xFFf8f9fa);
  static const shadow = Color(0x1A000000);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primary,
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: secondary,
      tertiary: accent,
      surface: cardBg,
      background: background,
      onBackground: text,
      onSurface: text,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: const TextStyle(color: text),
      displayMedium: const TextStyle(color: text),
      displaySmall: const TextStyle(color: text),
      headlineLarge: const TextStyle(color: text),
      headlineMedium: const TextStyle(color: text),
      headlineSmall: const TextStyle(color: text),
      titleLarge: const TextStyle(color: text),
      titleMedium: const TextStyle(color: text),
      titleSmall: const TextStyle(color: text),
      bodyLarge: const TextStyle(color: text),
      bodyMedium: const TextStyle(color: text),
      bodySmall: const TextStyle(color: textLight),
    ),
    scaffoldBackgroundColor: background,
    cardTheme: CardTheme(
      color: cardBg,
      elevation: 5,
      shadowColor: shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: primary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),
    iconTheme: const IconThemeData(color: primary),
    appBarTheme: AppBarTheme(
      backgroundColor: background.withOpacity(0.95),
      elevation: 0,
      scrolledUnderElevation: 5,
      shadowColor: shadow,
      titleTextStyle: GoogleFonts.poppins(
        color: text,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: accent,
    colorScheme: ColorScheme.dark(
      primary: accent,
      secondary: primary,
      tertiary: secondary,
      surface: dark,
      background: const Color(0xFF121212),
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: const TextStyle(color: Colors.white),
      displayMedium: const TextStyle(color: Colors.white),
      displaySmall: const TextStyle(color: Colors.white),
      headlineLarge: const TextStyle(color: Colors.white),
      headlineMedium: const TextStyle(color: Colors.white),
      headlineSmall: const TextStyle(color: Colors.white),
      titleLarge: const TextStyle(color: Colors.white),
      titleMedium: const TextStyle(color: Colors.white),
      titleSmall: const TextStyle(color: Colors.white),
      bodyLarge: const TextStyle(color: Colors.white),
      bodyMedium: const TextStyle(color: Colors.white),
      bodySmall: const TextStyle(color: Colors.white70),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardTheme: CardTheme(
      color: dark,
      elevation: 5,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accent,
        side: BorderSide(color: accent),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),
    iconTheme: IconThemeData(color: accent),
    appBarTheme: AppBarTheme(
      backgroundColor: dark.withOpacity(0.95),
      elevation: 0,
      scrolledUnderElevation: 5,
      shadowColor: Colors.black45,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
