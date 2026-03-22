import 'package:flutter/material.dart';
import 'int_colores.dart';

class IntTipografia {
  IntTipografia._();

  static const String _fontFamily = 'Inter';

  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 57,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25,
      color: IntColores.textPrimary,
    ),
    displayMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 45,
      fontWeight: FontWeight.w700,
      color: IntColores.textPrimary,
    ),
    displaySmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: IntColores.textPrimary,
    ),
    headlineLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: IntColores.textPrimary,
    ),
    headlineMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: IntColores.textPrimary,
    ),
    headlineSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: IntColores.textPrimary,
    ),
    titleLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: IntColores.textPrimary,
    ),
    titleMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: IntColores.textPrimary,
    ),
    titleSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: IntColores.textPrimary,
    ),
    bodyLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: IntColores.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: IntColores.textPrimary,
    ),
    bodySmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: IntColores.textSecondary,
    ),
    labelLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      color: IntColores.textPrimary,
    ),
    labelMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: IntColores.textPrimary,
    ),
    labelSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: IntColores.textSecondary,
    ),
  );
}
