import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod Provider for [ThemeNotifier]
final themeNotifierProvider = ChangeNotifierProvider((_) => ThemeNotifier());

/// A class that notifies listeners when the theme changes
class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;

  /// Current theme
  ThemeData get currentTheme => _currentTheme;

  /// Sets the current theme to [newTheme] and notifies listeners
  set currentTheme(ThemeData newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }

  /// Creates a new [ThemeNotifier] with [initialTheme].
  ThemeNotifier({ThemeData? initialTheme})
    : _currentTheme = initialTheme ?? ThemeData.light();
}
