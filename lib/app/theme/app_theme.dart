import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
  );

  return base.copyWith(
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      filled: true,
      fillColor: base.colorScheme.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: base.colorScheme.surface,
      foregroundColor: base.colorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: base.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: base.cardTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
    ),
  );
}
