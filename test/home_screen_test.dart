import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_color_app/core/theme_notifier.dart';
import 'package:random_color_app/home_screen.dart';

void main() {
  group('Home Screen', () {
    const String requiredText = 'Hello there';

    testWidgets('Shows "$requiredText"', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: HomeScreen())),
      );

      expect(find.text(requiredText), findsOneWidget);
    });

    testWidgets('Changes theme notifier theme on tap', (tester) async {
      final providerContainer = ProviderContainer();

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: providerContainer,
          child: const MaterialApp(home: HomeScreen()),
        ),
      );

      final themeNotifier = providerContainer.read(themeNotifierProvider);

      final capturedThemes = [themeNotifier.currentTheme];

      const testRandomNColors = 10;

      for (int i = 0; i < testRandomNColors; i++) {
        await tester.tap(find.text(requiredText));

        final newCurrentTheme = themeNotifier.currentTheme;

        expect(
          newCurrentTheme.colorScheme.primary,
          isNot(capturedThemes.last.colorScheme.primary),
        );

        capturedThemes.add(newCurrentTheme);
      }
    });
  });
}
