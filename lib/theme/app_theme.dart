import 'package:flutter/material.dart';

/// Rathnaveri Kavitha Official Fan Page - Imperial Crimson & Gold Design System
class RKTheme {
  // === BRAND COLORS ===
  static const Color primary = Color(0xFFD90429);        // Royal Ruby Crimson
  static const Color primaryLight = Color(0xFFEF233C);   // Bright Crimson
  static const Color primaryDark = Color(0xFF8D0801);    // Deep Maroon
  static const Color gold = Color(0xFFFFB703);           // Imperial Amber Gold
  static const Color goldLight = Color(0xFFFFD166);      // Radiant Gold
  static const Color goldDark = Color(0xFFFB8500);       // Burnished Bronze Gold
  static const Color emerald = Color(0xFF2A9D8F);        // Auspicious Emerald
  static const Color coral = Color(0xFFFF6B6B);

  // === BACKGROUNDS ===
  static const Color bgDark = Color(0xFF0B0F19);         // Obsidian Midnight
  static const Color bgDark2 = Color(0xFF111827);
  static const Color surfaceDark = Color(0xFF1A2234);
  static const Color cardDark = Color(0xFF1F293D);

  static const Color bgLight = Color(0xFFFAF9F6);        // Royal Warm Ivory
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFF4F1EA);

  // === GRADIENTS ===
  static const LinearGradient rubyGradient = LinearGradient(
    colors: [Color(0xFFD90429), Color(0xFF8D0801)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFFFB703), Color(0xFFFB8500)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient royalHeroGradient = LinearGradient(
    colors: [Color(0xFF1A050B), Color(0xFF2E0914), Color(0xFF0B0F19)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardVipGradient = LinearGradient(
    colors: [Color(0xFF2D0A14), Color(0xFF5A1224), Color(0xFF1F070E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGoldGradient = LinearGradient(
    colors: [Color(0xFF8F6306), Color(0xFFD4A373), Color(0xFF6B4701)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardSilverGradient = LinearGradient(
    colors: [Color(0xFF4A5568), Color(0xFF718096), Color(0xFF2D3748)],
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
        secondary: gold,
        surface: isDark ? surfaceDark : surfaceLight,
        brightness: brightness,
      ),
      scaffoldBackgroundColor: isDark ? bgDark : bgLight,
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        color: isDark ? cardDark : cardLight,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Outfit',
          color: isDark ? Colors.white : const Color(0xFF0B0F19),
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : const Color(0xFF0B0F19),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF161E2E) : const Color(0xFFF1EFEA),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark ? Colors.white12 : Colors.black12,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: gold, width: 2),
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
            ? const Color(0xFF0E1322).withValues(alpha: 0.96)
            : Colors.white.withValues(alpha: 0.96),
        elevation: 10,
        indicatorColor: primary.withValues(alpha: 0.18),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontFamily: 'Outfit',
              fontSize: 12,
              fontWeight: FontWeight.w700,
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
    );
  }
}
