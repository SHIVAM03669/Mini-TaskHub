import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Dark Theme Colors
  static const Color darkBackgroundColor = Color(0xFF1F2A37);
  static const Color darkCardBackground = Color(0xFF3B4A54);
  static const Color accentColor = Color(0xFFF2C94C);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFA0AEC0);
  static const Color darkInputBackground = Color(0xFF374151);

  // Light Theme Colors
  static const Color lightBackgroundColor = Color(0xFFF8FAFC);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1A202C);
  static const Color lightTextSecondary = Color(0xFF718096);
  static const Color lightInputBackground = Color(0xFFF7FAFC);

  // Legacy colors for backward compatibility
  static const Color backgroundColor = darkBackgroundColor;
  static const Color cardBackground = darkCardBackground;
  static const Color textPrimary = darkTextPrimary;
  static const Color textSecondary = darkTextSecondary;
  static const Color inputBackground = darkInputBackground;

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: accentColor,
        secondary: accentColor,
        surface: darkCardBackground,
        background: darkBackgroundColor,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: darkTextPrimary,
        onBackground: darkTextPrimary,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: darkTextPrimary),
          bodyMedium: TextStyle(color: darkTextPrimary),
          bodySmall: TextStyle(color: darkTextSecondary),
          labelLarge: TextStyle(color: darkTextPrimary),
          labelMedium: TextStyle(color: darkTextSecondary),
          labelSmall: TextStyle(color: darkTextSecondary),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: darkTextPrimary),
        titleTextStyle: TextStyle(
          color: darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkCardBackground,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkInputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: const TextStyle(color: darkTextSecondary),
        labelStyle: const TextStyle(color: darkTextSecondary),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkCardBackground,
        selectedItemColor: accentColor,
        unselectedItemColor: darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackgroundColor,
      colorScheme: const ColorScheme.light(
        primary: accentColor,
        secondary: accentColor,
        surface: lightCardBackground,
        background: lightBackgroundColor,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: lightTextPrimary,
        onBackground: lightTextPrimary,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: lightTextPrimary),
          bodyMedium: TextStyle(color: lightTextPrimary),
          bodySmall: TextStyle(color: lightTextSecondary),
          labelLarge: TextStyle(color: lightTextPrimary),
          labelMedium: TextStyle(color: lightTextSecondary),
          labelSmall: TextStyle(color: lightTextSecondary),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBackgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: lightTextPrimary),
        titleTextStyle: TextStyle(
          color: lightTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: lightCardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightInputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: const TextStyle(color: lightTextSecondary),
        labelStyle: const TextStyle(color: lightTextSecondary),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightCardBackground,
        selectedItemColor: accentColor,
        unselectedItemColor: lightTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}