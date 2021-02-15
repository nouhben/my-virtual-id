import 'package:flutter/material.dart';

class MyThemeProvider with ChangeNotifier {
  bool _isLightTheme = true;

  void toggleTheme() {
    _isLightTheme = !_isLightTheme;
    notifyListeners();
  }

  bool get isLightTheme => _isLightTheme;
}
