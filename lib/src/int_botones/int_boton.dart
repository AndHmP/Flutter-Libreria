import 'package:flutter/material.dart';
import '../int_tema/int_colores.dart';
import '../int_tema/int_espaciado.dart';

// ─────────────────────────────────────────────────────────────
// Enums
// ─────────────────────────────────────────────────────────────

enum IntBotonTamano { sm, md, lg }

enum IntBotonVariante { filled, outlined, ghost }

// ─────────────────────────────────────────────────────────────
// PrimaryButton
// ─────────────────────────────────────────────────────────────

/// A full-featured primary button supporting multiple sizes,
/// variants, loading state, icons and disabled state.
class IntBoton extends StatelessWidget {
  const IntBoton({
    super.key,
    required this.label,
    this.onPressed,
    this.size = IntBotonTamano.md,
    this.variant = IntBotonVariante.filled,
    this.color,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.tooltip,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.borderRadius,
  });

  final String label;
  final VoidCallback? onPressed;
  final IntBotonTamano size;
  final IntBotonVariante variant;
  final Color? color;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isLoading;
  final bool isFullWidth;

  /// Shows a tooltip on hover.
  final String? tooltip;

  /// Long press handler.
  final VoidCallback? onLongPress;

  /// Focus control.
  final FocusNode? focusNode;

  /// Whether the button should autofocus.
  final bool autofocus;

  /// Custom border radius override.
  final double? borderRadius;

  // Size mappings
  double get _height => switch (size) {
    IntBotonTamano.sm => 34,
    IntBotonTamano.md => 42,
    IntBotonTamano.lg => 52,
  };

  EdgeInsets get _padding => switch (size) {
    IntBotonTamano.sm => const EdgeInsets.symmetric(horizontal: IntEspaciado.md, vertical: IntEspaciado.xs),
    IntBotonTamano.md => const EdgeInsets.symmetric(horizontal: IntEspaciado.lg, vertical: IntEspaciado.sm),
    IntBotonTamano.lg => const EdgeInsets.symmetric(horizontal: IntEspaciado.xl2, vertical: IntEspaciado.md),
  };

  double get _fontSize => switch (size) {
    IntBotonTamano.sm => 13,
    IntBotonTamano.md => 14,
    IntBotonTamano.lg => 16,
  };

  double get _iconSize => switch (size) {
    IntBotonTamano.sm => 14,
    IntBotonTamano.md => 16,
    IntBotonTamano.lg => 18,
  };

  @override
  Widget build(BuildContext context) {
    final Color _resolvedColor = color ?? Theme.of(context).colorScheme.primary;
    final Color onPrimary = Theme.of(context).colorScheme.onPrimary;
    final bool disabled = onPressed == null || isLoading;

    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading)
          SizedBox(
            width: _iconSize,
            height: _iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: variant == IntBotonVariante.filled
                  ? onPrimary
                  : _resolvedColor,
            ),
          )
        else if (leadingIcon != null)
          Icon(leadingIcon, size: _iconSize),
        if (isLoading || leadingIcon != null)
          SizedBox(width: IntEspaciado.xs),
        Text(
          label,
          style: TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (trailingIcon != null) ...[
          SizedBox(width: IntEspaciado.xs),
          Icon(trailingIcon, size: _iconSize),
        ],
      ],
    );

    if (isFullWidth) {
      child = SizedBox(width: double.infinity, child: Center(child: child));
    }

    final resolvedRadius = borderRadius ?? 8;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(resolvedRadius),
    );

    Widget button = switch (variant) {
      IntBotonVariante.filled => ElevatedButton(
          onPressed: disabled ? null : onPressed,
          onLongPress: disabled ? null : onLongPress,
          focusNode: focusNode,
          autofocus: autofocus,
          style: ElevatedButton.styleFrom(
            backgroundColor: disabled ? IntColores.grey200 : _resolvedColor,
            foregroundColor: disabled ? IntColores.grey400 : onPrimary,
            elevation: 0,
            padding: _padding,
            minimumSize: Size(0, _height),
            shape: shape,
          ),
          child: child,
        ),
      IntBotonVariante.outlined => OutlinedButton(
          onPressed: disabled ? null : onPressed,
          onLongPress: disabled ? null : onLongPress,
          focusNode: focusNode,
          autofocus: autofocus,
          style: OutlinedButton.styleFrom(
            foregroundColor: disabled ? IntColores.grey400 : _resolvedColor,
            side: BorderSide(
              color: disabled ? IntColores.grey200 : _resolvedColor,
            ),
            padding: _padding,
            minimumSize: Size(0, _height),
            shape: shape,
          ),
          child: child,
        ),
      IntBotonVariante.ghost => TextButton(
          onPressed: disabled ? null : onPressed,
          onLongPress: disabled ? null : onLongPress,
          focusNode: focusNode,
          autofocus: autofocus,
          style: TextButton.styleFrom(
            foregroundColor: disabled ? IntColores.grey400 : _resolvedColor,
            padding: _padding,
            minimumSize: Size(0, _height),
            shape: shape,
          ),
          child: child,
        ),
    };

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}

// ─────────────────────────────────────────────────────────────
// IntBotonIcono
// ─────────────────────────────────────────────────────────────

class IntBotonIcono extends StatelessWidget {
  const IntBotonIcono({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.color,
    this.size = IntBotonTamano.md,
    this.variant = IntBotonVariante.filled,
    this.onLongPress,
    this.focusNode,
    this.backgroundColor,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? color;
  final IntBotonTamano size;
  final IntBotonVariante variant;

  /// Long press handler.
  final VoidCallback? onLongPress;

  /// Focus control.
  final FocusNode? focusNode;

  /// Custom background color.
  final Color? backgroundColor;

  double get _buttonSize => switch (size) {
    IntBotonTamano.sm => 32,
    IntBotonTamano.md => 40,
    IntBotonTamano.lg => 48,
  };

  double get _iconSize => switch (size) {
    IntBotonTamano.sm => 16,
    IntBotonTamano.md => 20,
    IntBotonTamano.lg => 24,
  };

  @override
  Widget build(BuildContext context) {
    final Color _resolvedColor = color ?? Theme.of(context).colorScheme.primary;
    final Color onPrimary = Theme.of(context).colorScheme.onPrimary;
    final Color _resolvedBg = backgroundColor ?? _resolvedColor;
    Widget button = SizedBox(
      width: _buttonSize,
      height: _buttonSize,
      child: switch (variant) {
        IntBotonVariante.filled => ElevatedButton(
            onPressed: onPressed,
            onLongPress: onLongPress,
            focusNode: focusNode,
            style: ElevatedButton.styleFrom(
              backgroundColor: _resolvedBg,
              foregroundColor: onPrimary,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Icon(icon, size: _iconSize),
          ),
        IntBotonVariante.outlined => OutlinedButton(
            onPressed: onPressed,
            onLongPress: onLongPress,
            focusNode: focusNode,
            style: OutlinedButton.styleFrom(
              foregroundColor: _resolvedColor,
              backgroundColor: backgroundColor,
              side: BorderSide(color: _resolvedColor),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Icon(icon, size: _iconSize),
          ),
        IntBotonVariante.ghost => IconButton(
            onPressed: onPressed,
            focusNode: focusNode,
            icon: Icon(icon, size: _iconSize, color: _resolvedColor),
            padding: EdgeInsets.zero,
            style: backgroundColor != null
                ? IconButton.styleFrom(backgroundColor: backgroundColor)
                : null,
            constraints: BoxConstraints(
              minWidth: _buttonSize,
              minHeight: _buttonSize,
            ),
          ),
      },
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}

// ─────────────────────────────────────────────────────────────
// IntBotonFab
// ─────────────────────────────────────────────────────────────

class IntBotonFab extends StatelessWidget {
  const IntBotonFab({
    super.key,
    required this.icon,
    this.label,
    this.onPressed,
    this.color,
    this.mini = false,
    this.tooltip,
    this.heroTag,
    this.elevation,
  });

  final IconData icon;
  final String? label;
  final VoidCallback? onPressed;
  final Color? color;
  final bool mini;

  /// Tooltip shown on hover.
  final String? tooltip;

  /// Hero animation tag.
  final Object? heroTag;

  /// Custom elevation.
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final bgColor = color ?? Theme.of(context).colorScheme.primary;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    final resolvedElevation = elevation ?? 2;

    if (label != null) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        backgroundColor: bgColor,
        foregroundColor: onPrimary,
        elevation: resolvedElevation,
        tooltip: tooltip,
        heroTag: heroTag,
        icon: Icon(icon),
        label: Text(
          label!,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: bgColor,
      foregroundColor: onPrimary,
      elevation: resolvedElevation,
      tooltip: tooltip,
      heroTag: heroTag,
      mini: mini,
      child: Icon(icon),
    );
  }
}
