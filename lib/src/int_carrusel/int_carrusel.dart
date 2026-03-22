import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../int_tema/int_colores.dart';
import '../int_tema/int_espaciado.dart';

// ─────────────────────────────────────────────────────────────
// IntPuntosIndicadores
// ─────────────────────────────────────────────────────────────

class IntPuntosIndicadores extends StatelessWidget {
  const IntPuntosIndicadores({
    super.key,
    required this.count,
    required this.current,
    this.onDotTap,
    this.activeColor,
    this.inactiveColor,
    this.dotSize = 8,
    this.activeDotWidth = 24,
    this.spacing = 6,
  });

  final int count;
  final int current;
  final ValueChanged<int>? onDotTap;
  final Color? activeColor;
  final Color? inactiveColor;
  final double dotSize;
  final double activeDotWidth;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return GestureDetector(
          onTap: onDotTap != null ? () => onDotTap!(i) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            margin: EdgeInsets.symmetric(horizontal: spacing / 2),
            width: isActive ? activeDotWidth : dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: isActive
                  ? (activeColor ?? Theme.of(context).colorScheme.primary)
                  : (inactiveColor ?? IntColores.grey300),
              borderRadius: BorderRadius.circular(dotSize / 2),
            ),
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// _MouseDragScrollBehavior – permite arrastrar con mouse en web
// ─────────────────────────────────────────────────────────────

class _MouseDragScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
      };
}

// ─────────────────────────────────────────────────────────────
// IntCarrusel
// ─────────────────────────────────────────────────────────────

class IntCarrusel<T> extends StatefulWidget {
  const IntCarrusel({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.height = 220,
    this.autoPlay = false,
    this.autoPlayDuration = const Duration(seconds: 4),
    this.showIndicator = true,
    this.showArrows = true,
    this.viewportFraction = 0.9,
    this.onPageChanged,
    this.initialPage = 0,
    this.infiniteScroll = true,
    this.itemSpacing = 8,
  });

  final List<T> items;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final double height;
  final bool autoPlay;
  final Duration autoPlayDuration;
  final bool showIndicator;
  final bool showArrows;
  final double viewportFraction;
  final ValueChanged<int>? onPageChanged;
  final int initialPage;
  final bool infiniteScroll;
  final double itemSpacing;

  @override
  State<IntCarrusel<T>> createState() => _IntCarruselState<T>();
}

class _IntCarruselState<T> extends State<IntCarrusel<T>> {
  late final PageController _gt_ctrldr;
  late int _gi_actual;
  late int _gi_offset;

  @override
  void initState() {
    super.initState();
    final count = widget.items.length;
    _gi_offset = widget.infiniteScroll && count > 0 ? count * 100 : 0;
    _gi_actual = widget.initialPage;
    _gt_ctrldr = PageController(
      initialPage: widget.initialPage + _gi_offset,
      viewportFraction: widget.viewportFraction,
    );

    if (widget.autoPlay && widget.items.length > 1) {
      _startAutoPlay();
    }
  }

  void _startAutoPlay() {
    Future.doWhile(() async {
      await Future.delayed(widget.autoPlayDuration);
      if (!mounted) return false;
      _next();
      return true;
    });
  }

  void _next() {
    _gt_ctrldr.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _prev() {
    _gt_ctrldr.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _goToPage(int index) {
    final count = widget.items.length;
    if (count == 0) return;
    final currentPage = _gt_ctrldr.page?.round() ?? (_gi_actual + _gi_offset);
    final currentReal = widget.infiniteScroll ? currentPage % count : currentPage;
    final delta = index - currentReal;
    _gt_ctrldr.animateToPage(
      currentPage + delta,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _gt_ctrldr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.items.length;
    if (count == 0) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height,
          child: Stack(
            children: [
              ScrollConfiguration(
                behavior: _MouseDragScrollBehavior(),
                child: PageView.builder(
                  controller: _gt_ctrldr,
                  itemCount: widget.infiniteScroll ? null : count,
                  onPageChanged: (index) {
                    final real = widget.infiniteScroll ? index % count : index;
                    setState(() => _gi_actual = real);
                    widget.onPageChanged?.call(real);
                  },
                  itemBuilder: (ctx, index) {
                    final real = widget.infiniteScroll ? index % count : index;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: widget.itemSpacing / 2),
                      child: widget.itemBuilder(ctx, widget.items[real], real),
                    );
                  },
                ),
              ),
              if (widget.showArrows && count > 1) ...[
                Positioned(
                  left: 0, top: 0, bottom: 0,
                  child: Center(child: _ArrowButton(icon: Icons.chevron_left, onTap: _prev)),
                ),
                Positioned(
                  right: 0, top: 0, bottom: 0,
                  child: Center(child: _ArrowButton(icon: Icons.chevron_right, onTap: _next)),
                ),
              ],
            ],
          ),
        ),
        if (widget.showIndicator && count > 1) ...[
          const SizedBox(height: IntEspaciado.md),
          IntPuntosIndicadores(count: count, current: _gi_actual, onDotTap: _goToPage),
        ],
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: IntEspaciado.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
