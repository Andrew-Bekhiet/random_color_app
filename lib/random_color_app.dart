import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_color_app/core/theme_notifier.dart';
import 'package:random_color_app/home_screen.dart' show HomeScreen;

/// App root widget
///
/// Responsible for showing [HomeScreen]
/// and automatically changing the app theme
/// based on [ThemeNotifier]
class RandomColorApp extends ConsumerWidget {
  /// Default constructor
  const RandomColorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider);

    return MaterialApp(
      title: 'Random Color App',
      theme: themeNotifier.currentTheme,
      home: const HomeScreen(),
    );
  }
}
