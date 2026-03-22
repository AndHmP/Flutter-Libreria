import 'package:flutter/material.dart';
import '../int_tema/int_colores.dart';
import '../int_tema/int_espaciado.dart';

// ─────────────────────────────────────────────────────────────
// IntElementoLista
// ─────────────────────────────────────────────────────────────

class IntElementoLista extends StatelessWidget {
  const IntElementoLista({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.showDivider = true,
    this.dense = false,
    this.enabled = true,
    this.tileColor,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool selected;
  final bool showDivider;
  final bool dense;
  final bool enabled;
  final Color? tileColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: leading,
          title: Text(
            title,
            style: TextStyle(
              fontSize: dense ? 13 : 14,
              fontWeight: FontWeight.w500,
              color: selected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                )
              : null,
          trailing: trailing,
          onTap: enabled ? onTap : null,
          onLongPress: enabled ? onLongPress : null,
          selected: selected,
          enabled: enabled,
          selectedColor: Theme.of(context).colorScheme.primary,
          selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.06),
          tileColor: tileColor,
          dense: dense,
          contentPadding: EdgeInsets.symmetric(
            horizontal: IntEspaciado.lg,
            vertical: dense ? 0 : IntEspaciado.xs,
          ),
        ),
        if (showDivider)
          const Divider(height: 1, indent: IntEspaciado.lg, endIndent: IntEspaciado.lg),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntVistaLista
// ─────────────────────────────────────────────────────────────

class IntVistaLista<T> extends StatelessWidget {
  const IntVistaLista({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.emptyBuilder,
    this.loadingBuilder,
    this.isLoading = false,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.separatorBuilder,
    this.onRefresh,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.errorBuilder,
    this.hasError = false,
  });

  final List<T> items;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final Widget Function(BuildContext)? emptyBuilder;
  final Widget Function(BuildContext)? loadingBuilder;
  final bool isLoading;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final Future<void> Function()? onRefresh;
  final ScrollController? controller;
  final Axis scrollDirection;
  final Widget Function(BuildContext)? errorBuilder;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingBuilder?.call(context) ??
          const Center(
            child: Padding(
              padding: EdgeInsets.all(IntEspaciado.xl3),
              child: CircularProgressIndicator(),
            ),
          );
    }

    if (hasError && errorBuilder != null) {
      return errorBuilder!(context);
    }

    if (items.isEmpty) {
      return emptyBuilder?.call(context) ??
          Center(
            child: Padding(
              padding: const EdgeInsets.all(IntEspaciado.xl3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.inbox_outlined, size: 48, color: IntColores.grey300),
                  const SizedBox(height: IntEspaciado.md),
                  Text(
                    'No items found',
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), fontSize: 14),
                  ),
                ],
              ),
            ),
          );
    }

    Widget listView;

    if (separatorBuilder != null) {
      listView = ListView.separated(
        controller: controller,
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
        physics: physics,
        padding: padding,
        itemCount: items.length,
        itemBuilder: (ctx, i) => itemBuilder(ctx, items[i], i),
        separatorBuilder: separatorBuilder!,
      );
    } else {
      listView = ListView.builder(
        controller: controller,
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
        physics: physics,
        padding: padding,
        itemCount: items.length,
        itemBuilder: (ctx, i) => itemBuilder(ctx, items[i], i),
      );
    }

    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: onRefresh!,
        child: listView,
      );
    }

    return listView;
  }
}

// ─────────────────────────────────────────────────────────────
// IntElementoDeslizable
// ─────────────────────────────────────────────────────────────

class IntElementoDeslizable extends StatelessWidget {
  const IntElementoDeslizable({
    super.key,
    required this.child,
    this.onDismissed,
    this.onEdit,
    this.dismissDirection = DismissDirection.endToStart,
    this.deleteBackground,
    this.editBackground,
    this.confirmDismiss,
    this.enabled = true,
  });

  final Widget child;
  final VoidCallback? onDismissed;
  final VoidCallback? onEdit;
  final DismissDirection dismissDirection;
  final Widget? deleteBackground;
  final Widget? editBackground;
  final Future<bool?> Function(DismissDirection)? confirmDismiss;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return Dismissible(
      key: UniqueKey(),
      direction: dismissDirection,
      confirmDismiss: confirmDismiss,
      onDismissed: onDismissed != null ? (_) => onDismissed!() : null,
      background: editBackground ??
          Container(
            color: IntColores.info,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: IntEspaciado.xl),
            child: Icon(Icons.edit_outlined, color: Theme.of(context).colorScheme.onPrimary),
          ),
      secondaryBackground: deleteBackground ??
          Container(
            color: IntColores.error,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: IntEspaciado.xl),
            child: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.onPrimary),
          ),
      child: child,
    );
  }
}
