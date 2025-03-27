import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_color_app/random_color_app.dart';

void main() {
  group('Random Color App', () {
    testWidgets('Shows HomeScreen', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: RandomColorApp()));

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Changes MaterialApp theme on ThemeNotifier change', (
      tester,
    ) async {
      final providerContainer = ProviderContainer();
      addTearDown(providerContainer.dispose);

      final themeNotifier = providerContainer.read(themeNotifierProvider);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: providerContainer,
          child: const RandomColorApp(),
        ),
      );

      MaterialApp materialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );

      expect(materialApp.theme, themeNotifier.currentTheme);

      themeNotifier.currentTheme = ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      );

      await tester.pumpAndSettle();

      materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      expect(materialApp.theme, themeNotifier.currentTheme);
    });
  });
}
