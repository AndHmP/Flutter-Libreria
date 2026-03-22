import 'package:flutter/material.dart';
import '../int_tema/int_colores.dart';
import '../int_tema/int_espaciado.dart';

// ─────────────────────────────────────────────────────────────
// IntTarjeta
// ─────────────────────────────────────────────────────────────

class IntTarjeta extends StatelessWidget {
  const IntTarjeta({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.borderColor,
    this.elevation = 0,
    this.onTap,
    this.borderRadius,
    this.margin,
    this.gradient,
    this.clipBehavior = Clip.antiAlias,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? borderColor;
  final double elevation;
  final VoidCallback? onTap;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final Gradient? gradient;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final resolvedBorderRadius = BorderRadius.circular(borderRadius ?? IntRadio.lg);

    Widget cardContent = InkWell(
      onTap: onTap,
      borderRadius: resolvedBorderRadius,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(IntEspaciado.lg),
        child: child,
      ),
    );

    if (gradient != null) {
      return Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Material(
          elevation: elevation,
          borderRadius: resolvedBorderRadius,
          clipBehavior: clipBehavior,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: resolvedBorderRadius,
              border: Border.all(color: borderColor ?? Theme.of(context).dividerColor),
            ),
            child: cardContent,
          ),
        ),
      );
    }

    return Card(
      color: color ?? Theme.of(context).colorScheme.surface,
      elevation: elevation,
      margin: margin,
      clipBehavior: clipBehavior,
      shape: RoundedRectangleBorder(
        borderRadius: resolvedBorderRadius,
        side: BorderSide(color: borderColor ?? Theme.of(context).dividerColor),
      ),
      child: cardContent,
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntTarjetaInfo
// ─────────────────────────────────────────────────────────────

class IntTarjetaInfo extends StatelessWidget {
  const IntTarjetaInfo({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    this.leading,
    this.trailing,
    this.onTap,
    this.badge,
    this.footerActions,
    this.elevation,
    this.onLongPress,
    this.contentPadding,
  });

  final String title;
  final String? subtitle;
  final String? description;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Widget? badge;
  final List<Widget>? footerActions;
  final double? elevation;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final onSurfaceMuted = onSurface.withOpacity(0.6);

    return IntTarjeta(
      onTap: onTap,
      elevation: elevation ?? 0,
      padding: contentPadding,
      child: GestureDetector(
        onLongPress: onLongPress,
        behavior: HitTestBehavior.translucent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: IntEspaciado.md),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: onSurface,
                              ),
                            ),
                          ),
                          if (badge != null) badge!,
                        ],
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 13,
                            color: onSurfaceMuted,
                          ),
                        ),
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: IntEspaciado.sm),
                  trailing!,
                ],
              ],
            ),
            if (description != null) ...[
              const SizedBox(height: IntEspaciado.sm),
              Text(
                description!,
                style: TextStyle(fontSize: 14, color: onSurfaceMuted),
              ),
            ],
            if (footerActions != null && footerActions!.isNotEmpty) ...[
              const SizedBox(height: IntEspaciado.md),
              const Divider(height: 1),
              const SizedBox(height: IntEspaciado.md),
              Row(children: footerActions!),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntTarjetaEstadisticas
// ─────────────────────────────────────────────────────────────

class IntTarjetaEstadisticas extends StatelessWidget {
  const IntTarjetaEstadisticas({
    super.key,
    required this.label,
    required this.value,
    this.change,
    this.changePositive,
    this.icon,
    this.iconColor,
    this.onTap,
    this.prefix,
    this.suffix,
    this.isLoading = false,
  });

  final String label;
  final String value;
  final String? change;
  final bool? changePositive;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final String? prefix;
  final String? suffix;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final onSurfaceMuted = onSurface.withOpacity(0.6);

    if (isLoading) {
      return IntTarjeta(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 14,
              decoration: BoxDecoration(
                color: onSurface.withOpacity(0.08),
                borderRadius: BorderRadius.circular(IntRadio.xs),
              ),
            ),
            const SizedBox(height: IntEspaciado.md),
            Container(
              width: 120,
              height: 28,
              decoration: BoxDecoration(
                color: onSurface.withOpacity(0.08),
                borderRadius: BorderRadius.circular(IntRadio.xs),
              ),
            ),
            const SizedBox(height: IntEspaciado.sm),
            Container(
              width: 60,
              height: 12,
              decoration: BoxDecoration(
                color: onSurface.withOpacity(0.08),
                borderRadius: BorderRadius.circular(IntRadio.xs),
              ),
            ),
          ],
        ),
      );
    }

    // Build the display value with optional prefix/suffix
    final displayValue = '${prefix ?? ''}$value${suffix != null ? ' $suffix' : ''}';

    return IntTarjeta(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: onSurfaceMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (icon != null)
                Container(
                  padding: const EdgeInsets.all(IntEspaciado.sm),
                  decoration: BoxDecoration(
                    color: (iconColor ?? Theme.of(context).colorScheme.primary).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(IntRadio.sm),
                  ),
                  child: Icon(icon, size: 18, color: iconColor ?? Theme.of(context).colorScheme.primary),
                ),
            ],
          ),
          const SizedBox(height: IntEspaciado.sm),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: onSurface,
            ),
          ),
          if (change != null) ...[
            const SizedBox(height: IntEspaciado.xs),
            Row(
              children: [
                Icon(
                  changePositive == true
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  size: 14,
                  color: changePositive == true ? IntColores.success : IntColores.error,
                ),
                const SizedBox(width: 2),
                Text(
                  change!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: changePositive == true ? IntColores.success : IntColores.error,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntTarjetaAccion
// ─────────────────────────────────────────────────────────────

class IntTarjetaAccion extends StatelessWidget {
  const IntTarjetaAccion({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.iconColor,
    required this.actions,
    this.onTap,
    this.elevation,
    this.enabled = true,
  });

  final String title;
  final String? description;
  final IconData? icon;
  final Color? iconColor;
  final List<Widget> actions;
  final VoidCallback? onTap;
  final double? elevation;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final onSurfaceMuted = onSurface.withOpacity(0.6);

    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: IntTarjeta(
        onTap: enabled ? onTap : null,
        elevation: elevation ?? 0,
        child: Row(
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(IntEspaciado.md),
                decoration: BoxDecoration(
                  color: (iconColor ?? Theme.of(context).colorScheme.primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(IntRadio.md),
                ),
                child: Icon(icon, color: iconColor ?? Theme.of(context).colorScheme.primary, size: 22),
              ),
              const SizedBox(width: IntEspaciado.md),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: onSurface,
                    ),
                  ),
                  if (description != null)
                    Text(
                      description!,
                      style: TextStyle(fontSize: 13, color: onSurfaceMuted),
                    ),
                ],
              ),
            ),
            ...actions,
          ],
        ),
      ),
    );
  }
}
