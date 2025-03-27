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

  Color _getNewRandomColor() {
    final newColorValue = _rng.nextInt(0xffffff); // max 16777216 colors

    // Always set alpha to 100%, because the alpha channel is not included in
    // the random color range and because we want the color to be opaque
    return Color(newColorValue).withValues(alpha: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Color App')),
      body: GestureDetector(
        onTap: () {
          final themeNotifier = ref.read(themeNotifierProvider);

          themeNotifier.currentTheme = ThemeData.from(
            colorScheme: ColorScheme.fromSeed(seedColor: _getNewRandomColor()),
          );
        },
        child: ColoredBox(
          color: ColorScheme.of(context).primary,
          child: const Center(child: Text('Hello there')),
        ),
      ),
    );
  }
}
