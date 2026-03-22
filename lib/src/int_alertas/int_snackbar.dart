import 'package:flutter/material.dart';
import '../int_tema/int_colores.dart';
import '../int_tema/int_espaciado.dart';

// ─────────────────────────────────────────────────────────────
// Alert type enum
// ─────────────────────────────────────────────────────────────

enum IntTipoAlerta { info, success, warning, error }

extension IntTipoAlertaX on IntTipoAlerta {
  Color get color => switch (this) {
    IntTipoAlerta.info    => IntColores.info,
    IntTipoAlerta.success => IntColores.success,
    IntTipoAlerta.warning => IntColores.warning,
    IntTipoAlerta.error   => IntColores.error,
  };

  Color get bgColor => switch (this) {
    IntTipoAlerta.info    => IntColores.infoLight,
    IntTipoAlerta.success => IntColores.successLight,
    IntTipoAlerta.warning => IntColores.warningLight,
    IntTipoAlerta.error   => IntColores.errorLight,
  };

  IconData get icon => switch (this) {
    IntTipoAlerta.info    => Icons.info_outline_rounded,
    IntTipoAlerta.success => Icons.check_circle_outline_rounded,
    IntTipoAlerta.warning => Icons.warning_amber_rounded,
    IntTipoAlerta.error   => Icons.error_outline_rounded,
  };
}

// ─────────────────────────────────────────────────────────────
// IntSnackbar
// ─────────────────────────────────────────────────────────────

class IntSnackbar {
  IntSnackbar._();

  static void show(
    BuildContext context, {
    required String message,
    IntTipoAlerta type = IntTipoAlerta.info,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(type.icon, color: IntColores.white, size: 18),
            const SizedBox(width: IntEspaciado.sm),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  color: IntColores.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: type.color,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(IntEspaciado.lg),
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: IntColores.white,
                onPressed: onAction ?? () {},
              )
            : null,
      ),
    );
  }

  static void success(BuildContext context, String message) =>
      show(context, message: message, type: IntTipoAlerta.success);

  static void error(BuildContext context, String message) =>
      show(context, message: message, type: IntTipoAlerta.error);

  static void warning(BuildContext context, String message) =>
      show(context, message: message, type: IntTipoAlerta.warning);

  static void info(BuildContext context, String message) =>
      show(context, message: message, type: IntTipoAlerta.info);
}

// ─────────────────────────────────────────────────────────────
// IntBanner
// ─────────────────────────────────────────────────────────────

/// An inline alert banner to embed in layouts.
class IntBanner extends StatelessWidget {
  const IntBanner({
    super.key,
    required this.message,
    this.type = IntTipoAlerta.info,
    this.title,
    this.onDismiss,
    this.action,
  });

  final String message;
  final IntTipoAlerta type;
  final String? title;
  final VoidCallback? onDismiss;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(IntEspaciado.md),
      decoration: BoxDecoration(
        color: type.bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: type.color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(type.icon, color: type.color, size: 18),
          const SizedBox(width: IntEspaciado.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: type.color,
                    ),
                  ),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 13,
                    color: type.color,
                  ),
                ),
                if (action != null) ...[
                  const SizedBox(height: IntEspaciado.sm),
                  action!,
                ],
              ],
            ),
          ),
          if (onDismiss != null)
            GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close, size: 16, color: type.color),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntToast (Overlay-based)
// ─────────────────────────────────────────────────────────────

class IntToast {
  IntToast._();

  static OverlayEntry? _entry;

  static void show(
    BuildContext context, {
    required String message,
    IntTipoAlerta type = IntTipoAlerta.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    _entry?.remove();

    _entry = OverlayEntry(
      builder: (_) => _ToastWidget(
        message: message,
        type: type,
        onRemove: () => _entry?.remove(),
        duration: duration,
      ),
    );

    Overlay.of(context).insert(_entry!);
  }
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    required this.message,
    required this.type,
    required this.onRemove,
    required this.duration,
  });

  final String message;
  final IntTipoAlerta type;
  final VoidCallback onRemove;
  final Duration duration;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _gt_ctrldr;
  late Animation<double> _go_opacty;

  @override
  void initState() {
    super.initState();
    _gt_ctrldr = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _go_opacty = CurvedAnimation(parent: _gt_ctrldr, curve: Curves.easeOut);
    _gt_ctrldr.forward();

    Future.delayed(widget.duration, () async {
      await _gt_ctrldr.reverse();
      widget.onRemove();
    });
  }

  @override
  void dispose() {
    _gt_ctrldr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + IntEspaciado.lg,
      left: IntEspaciado.lg,
      right: IntEspaciado.lg,
      child: FadeTransition(
        opacity: _go_opacty,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: IntEspaciado.lg,
              vertical: IntEspaciado.md,
            ),
            decoration: BoxDecoration(
              color: widget.type.color,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(widget.type.icon, color: IntColores.white, size: 18),
                const SizedBox(width: IntEspaciado.sm),
                Expanded(
                  child: Text(
                    widget.message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: IntColores.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
