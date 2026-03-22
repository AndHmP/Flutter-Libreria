import 'package:flutter/material.dart';

/// Central color palette for the UI library.
///
/// ## Cómo cambiar el color predominante de los inputs
///
/// Los inputs (TextField, Dropdown, Password, OTP, Checkbox, Switch, Radio)
/// usan [IntColores.primary] como color de acento por defecto. Existen **3 niveles**
/// para personalizar el color:
///
/// ### 1. Global — Cambiar el color primario de toda la librería
/// Modifica las constantes `primary`, `primaryLight` y `primaryDark` en esta clase:
/// ```dart
/// // En app_colors.dart, reemplaza:
/// static const Color primary      = Color(0xFFE91E63); // Tu color
/// static const Color primaryLight = Color(0xFFF48FB1);
/// static const Color primaryDark  = Color(0xFFC2185B);
/// ```
/// Esto cambia el color de TODOS los componentes automáticamente (inputs,
/// botones, switches, checkboxes, radios, etc.).
///
/// ### 2. Por tema — Sobreescribir en el ThemeData
/// Si no quieres modificar la librería directamente, sobreescribe el tema:
/// ```dart
/// MaterialApp(
///   theme: IntTema.light.copyWith(
///     colorScheme: IntTema.light.colorScheme.copyWith(
///       primary: Color(0xFFE91E63), // Tu color
///     ),
///     inputDecorationTheme: IntTema.light.inputDecorationTheme.copyWith(
///       focusedBorder: OutlineInputBorder(
///         borderRadius: BorderRadius.circular(IntRadio.md),
///         borderSide: BorderSide(color: Color(0xFFE91E63), width: 2),
///       ),
///     ),
///   ),
/// );
/// ```
///
/// ### 3. Por componente — Usar la propiedad `activeColor`
/// Cada input acepta un parámetro `activeColor` para override individual:
/// ```dart
/// IntCasilla(value: v, onChanged: fn, activeColor: Colors.green);
/// IntInterruptor(value: v, onChanged: fn, activeColor: Colors.orange);
/// IntCampoClave(/* ... */);  // Usa el tema automáticamente
/// IntCampoOtp(activeColor: Colors.purple, /* ... */);
/// ```
class IntColores {
  IntColores._();

  // ── Brand ──────────────────────────────────────────────
  static const Color primary = Color(0xFF2563EB);       // Blue 600
  static const Color primaryLight = Color(0xFF93C5FD);  // Blue 300
  static const Color primaryDark = Color(0xFF1E40AF);   // Blue 800

  static const Color secondary = Color(0xFF7C3AED);     // Violet 600
  static const Color secondaryLight = Color(0xFFC4B5FD);
  static const Color secondaryDark = Color(0xFF5B21B6);

  static const Color accent = Color(0xFF06B6D4);        // Cyan 500

  // ── Semantic ───────────────────────────────────────────
  static const Color success = Color(0xFF16A34A);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFD97706);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFDC2626);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF0284C7);
  static const Color infoLight = Color(0xFFE0F2FE);

  // ── Neutrals ───────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF0A0A0A);

  static const Color grey50  = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  // ── Surface / Background ───────────────────────────────
  static const Color background = Color(0xFFF9FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3F4F6);
  static const Color border = Color(0xFFE5E7EB);

  // ── Text ───────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textDisabled  = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
}
