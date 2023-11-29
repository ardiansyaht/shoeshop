import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  bool _isDarkMode = false;
  Color? _backgroundColor = Colors.grey[300];
  Color? _textColor = Colors.black; // Tambahkan variabel _textColor

  bool get isDarkMode => _isDarkMode;
  Color? get backgroundColor => _backgroundColor;
  Color? get textColor => _textColor; // Tambahkan getter untuk textColor

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _backgroundColor = _isDarkMode ? Colors.grey[900] : Colors.grey[300];
    _textColor = _isDarkMode ? Colors.white : Colors.black; // Sesuaikan warna teks berdasarkan mode tema
    notifyListeners();
  }
}