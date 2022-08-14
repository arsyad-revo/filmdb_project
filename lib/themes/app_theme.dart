import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  ThemeData? _themeData;
  ThemeData? getTheme() => _themeData;

  String? mode = 'light';
  bool isDarkMode = false;

  AppTheme() {
    if (mode == 'light') {
      _themeData = lightTheme;
      isDarkMode = false;
    } else {
      _themeData = darkTheme;
      isDarkMode = true;
    }
    notifyListeners();
  }

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(),
      textTheme: ThemeData.light().textTheme.apply(),
      primaryTextTheme: ThemeData.light().textTheme.apply(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
      ));

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey[900],
      colorScheme: const ColorScheme.dark(background: Colors.black45),
      textTheme: ThemeData.dark().textTheme.apply(),
      primaryTextTheme: ThemeData.dark().textTheme.apply(),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[850],
      ));

  void setThemeMode() async {
    if (isDarkMode) {
      _themeData = lightTheme;
      isDarkMode = false;
    } else {
      _themeData = darkTheme;
      isDarkMode = true;
    }
    notifyListeners();
  }
}
