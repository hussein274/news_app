import 'package:flutter/material.dart';

class ThemeModeProvider extends ChangeNotifier {
  var currentTheme = ThemeMode.dark;

  bool get isDarkMode => currentTheme == ThemeMode.dark;
  void changeTheme(ThemeMode newTheme) {
    currentTheme = newTheme;
    notifyListeners();
  }
}
