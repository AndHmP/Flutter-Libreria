import 'package:flutter/material.dart';
import '../int_tema/int_colores.dart';
import '../int_tema/int_espaciado.dart';
import '../int_botones/int_boton.dart';

// ─────────────────────────────────────────────────────────────
// IntDialogo
// ─────────────────────────────────────────────────────────────

class IntDialogo extends StatelessWidget {
  const IntDialogo({
    super.key,
    required this.title,
    this.content,
    this.contentWidget,
    this.actions,
    this.icon,
    this.iconColor,
    this.maxWidth = 480,
    this.scrollable = false,
    this.contentPadding,
  });

  final String title;
  final String? content;
  final Widget? contentWidget;
  final List<Widget>? actions;
  final IconData? icon;
  final Color? iconColor;
  final double maxWidth;

  /// Makes the dialog content scrollable when true.
  final bool scrollable;

  /// Custom padding for the content area.
  final EdgeInsetsGeometry? contentPadding;

  /// Convenience static helper to show the dialog.
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    String? content,
    Widget? contentWidget,
    List<Widget>? actions,
    IconData? icon,
    Color? iconColor,
    bool barrierDismissible = true,
    bool scrollable = false,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => IntDialogo(
        title: title,
        content: content,
        contentWidget: contentWidget,
        actions: actions,
        icon: icon,
        iconColor: iconColor,
        scrollable: scrollable,
        contentPadding: contentPadding,
      ),
    );
  }

  /// Confirm dialog shortcut.
  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    String? message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    Color? confirmColor,
    bool destructive = false,
  }) {
    final primary = Theme.of(context).colorScheme.primary;
    final resolvedColor = confirmColor ?? primary;
    return show<bool>(
      context,
      title: title,
      content: message,
      icon: destructive ? Icons.warning_amber_rounded : Icons.help_outline_rounded,
      iconColor: destructive ? IntColores.error : primary,
      actions: [
        IntBoton(
          label: cancelLabel,
          variant: IntBotonVariante.ghost,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        IntBoton(
          label: confirmLabel,
          color: destructive ? IntColores.error : resolvedColor,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final onSurfaceMuted = onSurface.withOpacity(0.6);
    final resolvedPadding = contentPadding ?? const EdgeInsets.all(IntEspaciado.xl2);

    Widget buildBody() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(IntEspaciado.md),
              decoration: BoxDecoration(
                color: (iconColor ?? Theme.of(context).colorScheme.primary).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor ?? Theme.of(context).colorScheme.primary, size: 24),
            ),
            const SizedBox(height: IntEspaciado.lg),
          ],
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: onSurface,
            ),
          ),
          if (content != null) ...[
            const SizedBox(height: IntEspaciado.sm),
            Text(
              content!,
              style: TextStyle(fontSize: 14, color: onSurfaceMuted),
            ),
          ],
          if (contentWidget != null) ...[
            const SizedBox(height: IntEspaciado.md),
            contentWidget!,
          ],
          if (actions != null && actions!.isNotEmpty) ...[
            const SizedBox(height: IntEspaciado.xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions!
                  .expand((a) => [a, const SizedBox(width: IntEspaciado.sm)])
                  .toList()
                ..removeLast(),
            ),
          ],
        ],
      );
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: resolvedPadding,
          child: scrollable
              ? SingleChildScrollView(child: buildBody())
              : buildBody(),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntHojaInferior
// ─────────────────────────────────────────────────────────────

class IntHojaInferior extends StatelessWidget {
  const IntHojaInferior({
    super.key,
    required this.child,
    this.title,
    this.showHandle = true,
    this.showCloseButton = false,
    this.padding,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.25,
    this.maxChildSize = 0.9,
    this.expand = false,
    this.backgroundColor,
    this.onDismissed,
  });

  final Widget child;
  final String? title;
  final bool showHandle;
  final bool showCloseButton;
  final EdgeInsetsGeometry? padding;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final bool expand;

  /// Custom background color for the bottom sheet.
  final Color? backgroundColor;

  /// Callback invoked when the bottom sheet is dismissed.
  final VoidCallback? onDismissed;

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool showHandle = true,
    bool showCloseButton = false,
    double initialChildSize = 0.5,
    double minChildSize = 0.25,
    double maxChildSize = 0.9,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    VoidCallback? onDismissed,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (_) => IntHojaInferior(
        title: title,
        showHandle: showHandle,
        showCloseButton: showCloseButton,
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        backgroundColor: backgroundColor,
        onDismissed: onDismissed,
        child: child,
      ),
    ).then((result) {
      onDismissed?.call();
      return result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      expand: expand,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showHandle) ...[
                const SizedBox(height: IntEspaciado.md),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: IntColores.grey200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: IntEspaciado.md),
              ],
              if (title != null || showCloseButton)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: IntEspaciado.lg),
                  child: Row(
                    children: [
                      if (title != null)
                        Expanded(
                          child: Text(
                            title!,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      if (showCloseButton)
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                    ],
                  ),
                ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: padding ?? const EdgeInsets.all(IntEspaciado.lg),
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntMenuEmergente
// ─────────────────────────────────────────────────────────────

class IntMenuEmergenteItem {
  const IntMenuEmergenteItem({
    required this.value,
    required this.label,
    this.icon,
    this.iconColor,
    this.destructive = false,
    this.dividerAbove = false,
  });

  final String value;
  final String label;
  final IconData? icon;
  final Color? iconColor;
  final bool destructive;
  final bool dividerAbove;
}

class IntMenuEmergente extends StatelessWidget {
  const IntMenuEmergente({
    super.key,
    required this.items,
    required this.onSelected,
    this.child,
    this.tooltip,
    this.offset = Offset.zero,
    this.enabled = true,
    this.elevation,
    this.borderRadius,
  });

  final List<IntMenuEmergenteItem> items;
  final ValueChanged<String> onSelected;
  final Widget? child;
  final String? tooltip;
  final Offset offset;

  /// Disables the menu when false.
  final bool enabled;

  /// Shadow depth of the popup menu.
  final double? elevation;

  /// Corner radius of the popup menu.
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final onSurfaceMuted = onSurface.withOpacity(0.6);
    final menuItems = <PopupMenuEntry<String>>[];

    for (final item in items) {
      if (item.dividerAbove && menuItems.isNotEmpty) {
        menuItems.add(const PopupMenuDivider());
      }
      menuItems.add(
        PopupMenuItem<String>(
          value: item.value,
          child: Row(
            children: [
              if (item.icon != null) ...[
                Icon(
                  item.icon,
                  size: 16,
                  color: item.destructive
                      ? IntColores.error
                      : (item.iconColor ?? onSurfaceMuted),
                ),
                const SizedBox(width: IntEspaciado.sm),
              ],
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 14,
                  color: item.destructive ? IntColores.error : onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(12);

    return PopupMenuButton<String>(
      itemBuilder: (_) => menuItems,
      onSelected: onSelected,
      enabled: enabled,
      tooltip: tooltip,
      offset: offset,
      shape: RoundedRectangleBorder(
        borderRadius: resolvedBorderRadius,
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      elevation: elevation ?? 4,
      child: child ?? const Icon(Icons.more_vert_rounded, color: IntColores.grey400),
    );
  }
}
