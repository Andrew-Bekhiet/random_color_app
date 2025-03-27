import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_color_app/core/theme_notifier.dart';

void main() {
  group('ThemeNotifier', () {
    final initialTheme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    );

    test('Sets current theme to initial theme', () {
      final themeNotifier = ThemeNotifier(initialTheme: initialTheme);
      addTearDown(themeNotifier.dispose);

      expect(themeNotifier.currentTheme, initialTheme);
    });

    test('Notifies listeners on theme changed', () {
      bool notified = false;

      void mockListener() => notified = true;

      final themeNotifier = ThemeNotifier(initialTheme: initialTheme);
      themeNotifier.addListener(mockListener);

      addTearDown(() {
        themeNotifier.removeListener(mockListener);
        themeNotifier.dispose();
      });

      themeNotifier.currentTheme = ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      );

      expect(notified, isTrue);
    });
  });
}
