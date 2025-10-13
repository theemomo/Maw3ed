import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getLightTheme(Locale locale) {
    final isArabic = locale.languageCode == 'ar';

    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      colorScheme: const ColorScheme.light(
        surface: Color(0xFFE0E0E0),
        primary: Color(0xFF222222),
        onPrimary: Colors.grey,
        secondary: Color(0xFFE0E0E0),
        tertiary: Colors.white,
        inversePrimary: Color(0xFF000000),
      ),
      cardColor: Colors.white,
      textTheme: isArabic
          ? GoogleFonts.tajawalTextTheme(
              const TextTheme(
                titleLarge: TextStyle(
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                bodyMedium: TextStyle(color: Color(0xFF444444), fontSize: 16),
              ),
            )
          : GoogleFonts.montserratTextTheme(
              const TextTheme(
                titleLarge: TextStyle(
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                bodyMedium: TextStyle(color: Color(0xFF444444), fontSize: 16),
              ),
            ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF222222)),
      ),
    );
  }

  static ThemeData getDarkTheme(Locale locale) {
    final isArabic = locale.languageCode == 'ar';

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      colorScheme: const ColorScheme.dark(
        surface: Color(0xFF1E1E1E),
        primary: Color(0xFFE0E0E0),
        secondary: Color(0xFF2A2A2A),
        tertiary: Color(0xFF000000),
        inversePrimary: Color(0xFFFFFFFF),
      ),
      cardColor: const Color(0xFF1E1E1E),
      textTheme: isArabic
          ? GoogleFonts.tajawalTextTheme(
              const TextTheme(
                titleLarge: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                bodyMedium: TextStyle(color: Color(0xFFCCCCCC), fontSize: 16),
              ),
            )
          : GoogleFonts.montserratTextTheme(
              const TextTheme(
                titleLarge: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                bodyMedium: TextStyle(color: Color(0xFFCCCCCC), fontSize: 16),
              ),
            ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}
