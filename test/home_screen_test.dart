import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_color_app/random_color_app.dart';

void main() {
  group('Home Screen', () {
    const String requiredText = 'Hello there';

    testWidgets('Shows "$requiredText"', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: HomeScreen())),
      );

      expect(find.text(requiredText), findsOneWidget);
    });

    testWidgets('Changes theme notifier theme on tap with opaque color', (
      tester,
    ) async {
      final providerContainer = ProviderContainer();
      addTearDown(providerContainer.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: providerContainer,
          child: const MaterialApp(home: HomeScreen()),
        ),
      );

      final themeNotifier = providerContainer.read(themeNotifierProvider);

      final initialTheme = themeNotifier.currentTheme;

      const testRandomNColors = 10;
      Color previousPrimaryColor = initialTheme.colorScheme.primary;

      for (int i = 0; i < testRandomNColors; i++) {
        await tester.tap(find.text(requiredText));

        final newCurrentTheme = themeNotifier.currentTheme;
        final newCurrentPrimaryColor = newCurrentTheme.colorScheme.primary;

        expect(newCurrentPrimaryColor, isNot(previousPrimaryColor));
        expect(newCurrentPrimaryColor.a, 1);

        previousPrimaryColor = newCurrentPrimaryColor;
      }
    });
  });
}
