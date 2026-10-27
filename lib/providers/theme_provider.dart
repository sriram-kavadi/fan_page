import 'package:flutter/foundation.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = true; // Default to dark for studio feel

  bool get isDark => _isDark;
  bool get isDarkMode => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  void setDark(bool value) {
    _isDark = value;
    notifyListeners();
  }
}
