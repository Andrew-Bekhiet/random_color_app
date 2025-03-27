import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_color_app/random_color_app.dart';

void main() {
  runApp(const ProviderScope(child: RandomColorApp()));
}
