import 'package:flutter/material.dart';
import 'int_colores.dart';
import 'int_tipografia.dart';
import 'int_espaciado.dart';

class IntTema {
  IntTema._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    colorScheme: const ColorScheme.light(
      primary: IntColores.primary,
      primaryContainer: IntColores.primaryLight,
      secondary: IntColores.secondary,
      secondaryContainer: IntColores.secondaryLight,
      error: IntColores.error,
      surface: IntColores.surface,
      onPrimary: IntColores.textOnPrimary,
      onSecondary: IntColores.textOnPrimary,
      onSurface: IntColores.textPrimary,
    ),
    scaffoldBackgroundColor: IntColores.background,
    textTheme: IntTipografia.textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: IntColores.surface,
      foregroundColor: IntColores.textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: IntColores.textPrimary,
      ),
    ),
    cardTheme: CardThemeData(
      color: IntColores.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(IntRadio.lg),
        side: const BorderSide(color: IntColores.border),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: IntColores.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: IntEspaciado.lg,
        vertical: IntEspaciado.md,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(IntRadio.md),
        borderSide: const BorderSide(color: IntColores.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(IntRadio.md),
        borderSide: const BorderSide(color: IntColores.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(IntRadio.md),
        borderSide: const BorderSide(color: IntColores.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(IntRadio.md),
        borderSide: const BorderSide(color: IntColores.error),
      ),
      hintStyle: const TextStyle(color: IntColores.textDisabled, fontSize: 14),
      labelStyle: const TextStyle(color: IntColores.textSecondary, fontSize: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: IntColores.primary,
        foregroundColor: IntColores.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: IntEspaciado.xl,
          vertical: IntEspaciado.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(IntRadio.md),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: IntColores.border,
      thickness: 1,
      space: 1,
    ),
  );

  static const _darkSurface = Color(0xFF1F2937);
  static const _darkBg = Color(0xFF111827);
  static const _darkBorder = Color(0xFF374151);
  static const _darkTextPrimary = IntColores.grey100;
  static const _darkTextSecondary = IntColores.grey400;
  static const _darkTextDisabled = IntColores.grey600;

  static ThemeData get dark => light.copyWith(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: IntColores.primaryLight,
      secondary: IntColores.secondaryLight,
      surface: _darkSurface,
      onSurface: _darkTextPrimary,
      onPrimary: IntColores.black,
    ),
    scaffoldBackgroundColor: _darkBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkSurface,
      foregroundColor: _darkTextPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: _darkTextPrimary,
      ),
    ),
    cardTheme: CardThemeData(
      color: _darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(IntRadio.lg),
        side: const BorderSide(color: _darkBorder),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkSurface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: IntEspaciado.lg,
        vertical: IntEspaciado.md,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(IntRadio.md),
        borderSide: const BorderSide(color: _darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(IntRadio.md),
        borderSide: const BorderSide(color: _darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(IntRadio.md),
        borderSide: const BorderSide(color: IntColores.primaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(IntRadio.md),
        borderSide: const BorderSide(color: IntColores.error),
      ),
      hintStyle: const TextStyle(color: _darkTextDisabled, fontSize: 14),
      labelStyle: const TextStyle(color: _darkTextSecondary, fontSize: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: IntColores.primaryLight,
        foregroundColor: IntColores.black,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: IntEspaciado.xl,
          vertical: IntEspaciado.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(IntRadio.md),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: _darkBorder,
      thickness: 1,
      space: 1,
    ),
  );
}
