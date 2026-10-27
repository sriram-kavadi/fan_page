import 'package:flutter/material.dart';

/// Nikhil's Fantasy Studio - Brand Color System
class StudioTheme {
  // === PRIMARY BRAND PALETTE ===
  static const Color primary = Color(0xFF0A84FF);        // Electric Blue
  static const Color primaryLight = Color(0xFF40A0FF);
  static const Color primaryDark = Color(0xFF0060D0);
  static const Color secondary = Color(0xFF00C896);      // Mint Green
  static const Color secondaryLight = Color(0xFF33DDAA);
  static const Color accent = Color(0xFFFF6B6B);         // Coral Red
  static const Color accentGold = Color(0xFFFFD700);     // Gold Star
  static const Color purple = Color(0xFF9B59B6);         // Creative Purple
  static const Color teal = Color(0xFF00BCD4);

  // === BACKGROUNDS ===
  static const Color bgDark = Color(0xFF0A0E1A);         // Deep navy
  static const Color bgDark2 = Color(0xFF111827);
  static const Color surfaceDark = Color(0xFF1A2035);
  static const Color cardDark = Color(0xFF1E2640);
  static const Color bgLight = Color(0xFFF0F4FF);        // Soft lavender white
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFF8FAFF);

  // === GRADIENTS ===
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0A1628), Color(0xFF0D2548), Color(0xFF0A1628)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0A84FF), Color(0xFF0060D0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient mintGradient = LinearGradient(
    colors: [Color(0xFF00C896), Color(0xFF00BCD4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFF9B59B6), Color(0xFF6C3483)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get lightTheme => _buildTheme(Brightness.light);
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Outfit',
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        surface: isDark ? surfaceDark : surfaceLight,
        brightness: brightness,
      ),
      scaffoldBackgroundColor: isDark ? bgDark : bgLight,
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: isDark ? cardDark : cardLight,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Outfit',
          color: isDark ? Colors.white : const Color(0xFF0A0E1A),
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : const Color(0xFF0A0E1A),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF1A2035) : const Color(0xFFF0F4FF),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: isDark ? Colors.white12 : Colors.black12,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        hintStyle: TextStyle(
          color: isDark ? Colors.white38 : Colors.black38,
          fontFamily: 'Outfit',
        ),
        labelStyle: TextStyle(
          color: isDark ? Colors.white60 : Colors.black54,
          fontFamily: 'Outfit',
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDark
            ? const Color(0xFF111827).withValues(alpha: 0.95)
            : Colors.white.withValues(alpha: 0.95),
        elevation: 8,
        indicatorColor: primary.withValues(alpha: 0.15),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontFamily: 'Outfit',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primary,
            );
          }
          return TextStyle(
            fontFamily: 'Outfit',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white38 : Colors.black38,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primary, size: 24);
          }
          return IconThemeData(
            color: isDark ? Colors.white38 : Colors.black38,
            size: 22,
          );
        }),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: isDark ? const Color(0xFF1E2640) : const Color(0xFFECF3FF),
        selectedColor: primary.withValues(alpha: 0.2),
        labelStyle: TextStyle(
          fontFamily: 'Outfit',
          color: isDark ? Colors.white70 : const Color(0xFF0A0E1A),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),
    );
  }
}
