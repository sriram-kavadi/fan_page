import 'package:flutter_test/flutter_test.dart';
import 'package:nikhils_fantasy_studio/providers/theme_provider.dart';

void main() {
  group('ThemeProvider Unit Tests', () {
    test('Default theme is dark for studio creative feel', () {
      final provider = ThemeProvider();
      expect(provider.isDark, isTrue);
      expect(provider.isDarkMode, isTrue);
    });

    test('Toggling theme switches between dark and light', () {
      final provider = ThemeProvider();

      provider.toggleTheme();
      expect(provider.isDark, isFalse);

      provider.toggleTheme();
      expect(provider.isDark, isTrue);
    });

    test('Explicit setDark modifies theme state', () {
      final provider = ThemeProvider();

      provider.setDark(false);
      expect(provider.isDark, isFalse);

      provider.setDark(true);
      expect(provider.isDark, isTrue);
    });
  });
}
