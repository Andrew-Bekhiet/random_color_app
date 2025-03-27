import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_color_app/random_color_app.dart';

/// App Default Home Screen
/// Shows "Hello there" text
/// and changes the app theme color on tap
class HomeScreen extends ConsumerStatefulWidget {
  /// Creates a new instance of [HomeScreen]
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final Random _rng = Random();

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final primaryColor = colorScheme.primary;

    return GestureDetector(
      onTap: _changeToRandomTheme,
      child: Scaffold(
        appBar: AppBar(title: const Text('Random Color App')),
        body: ColoredBox(
          color: primaryColor,
          child: Center(
            child: Text(
              'Hello there',
              style: TextStyle(color: colorScheme.onPrimary),
            ),
          ),
        ),
      ),
    );
  }

  void _changeToRandomTheme() {
    final themeNotifier = ref.read(themeNotifierProvider);

    final newRandomColor = _getNewRandomColor();

    themeNotifier.currentTheme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: newRandomColor,
        primary: newRandomColor,
        onPrimary: _onColor(newRandomColor),
      ),
    );
  }

  Color _getNewRandomColor() {
    final newColorValue = _rng.nextInt(0xffffff); // max 16777216 colors

    // Always set alpha to 100%, because the alpha channel is not included in
    // the random color range and because we want the color to be opaque
    return Color(newColorValue).withValues(alpha: 1);
  }

  Color _onColor(Color newRandomColor) {
    const luminanceBreakpoint = 0.55;

    return newRandomColor.computeLuminance() > luminanceBreakpoint
        ? Colors.black
        : Colors.white;
  }
}
