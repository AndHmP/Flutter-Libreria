import 'package:flutter/material.dart';
import '../int_tema/int_colores.dart';
import '../int_tema/int_espaciado.dart';

// ─────────────────────────────────────────────────────────────
// AppStep model
// ─────────────────────────────────────────────────────────────

class IntDatoPaso {
  const IntDatoPaso({
    required this.title,
    this.subtitle,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
}

// ─────────────────────────────────────────────────────────────
// IntPasos
// ─────────────────────────────────────────────────────────────

enum StepperDirection { horizontal, vertical }

class IntPasos extends StatelessWidget {
  const IntPasos({
    super.key,
    required this.steps,
    required this.currentStep,
    this.direction = StepperDirection.horizontal,
    this.activeColor,
    this.onStepTap,
    this.onStepContinue,
    this.onStepCancel,
    this.completedSteps,
  });

  final List<IntDatoPaso> steps;
  final int currentStep;
  final StepperDirection direction;
  final Color? activeColor;
  final ValueChanged<int>? onStepTap;

  /// Callback invoked to advance to the next step.
  final VoidCallback? onStepContinue;

  /// Callback invoked to go back to the previous step.
  final VoidCallback? onStepCancel;

  /// Indices of explicitly completed steps (show checkmark regardless of currentStep).
  final Set<int>? completedSteps;

  @override
  Widget build(BuildContext context) {
    final _active = activeColor ?? Theme.of(context).colorScheme.primary;
    final _onActive = Theme.of(context).colorScheme.onPrimary;
    final _onSurfaceMuted = Theme.of(context).colorScheme.onSurface.withOpacity(0.6);
    return direction == StepperDirection.horizontal
        ? _buildHorizontal(_active, _onActive, _onSurfaceMuted)
        : _buildVertical(_active, _onActive, _onSurfaceMuted);
  }

  /// Returns true if the step at [index] should be displayed as completed.
  bool _isStepCompleted(int index) {
    if (completedSteps != null && completedSteps!.contains(index)) return true;
    return index < currentStep;
  }

  Widget _buildHorizontal(Color _active, Color _onActive, Color _onSurfaceMuted) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: steps.asMap().entries.map((e) {
            final i = e.key;
            final step = e.value;
            final isCompleted = _isStepCompleted(i);
            final isCurrent = i == currentStep;
            final isLast = i == steps.length - 1;

            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onStepTap != null ? () => onStepTap!(i) : null,
                      child: Column(
                        children: [
                          // Circle
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? _active
                                  : isCurrent
                                      ? _active
                                      : IntColores.grey100,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isCurrent || isCompleted
                                    ? _active
                                    : IntColores.grey300,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: isCompleted
                                  ? Icon(Icons.check_rounded,
                                      size: 16, color: _onActive)
                                  : step.icon != null
                                      ? Icon(step.icon,
                                          size: 16,
                                          color: isCurrent
                                              ? _onActive
                                              : IntColores.grey400)
                                      : Text(
                                          '${i + 1}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: isCurrent || isCompleted
                                                ? _onActive
                                                : IntColores.grey400,
                                          ),
                                        ),
                            ),
                          ),
                          const SizedBox(height: IntEspaciado.xs),
                          Text(
                            step.title,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                              color: isCurrent || isCompleted
                                  ? _active
                                  : _onSurfaceMuted,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: IntEspaciado.xl),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          height: 2,
                          color: i < currentStep ? _active : IntColores.grey200,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
        if (onStepContinue != null || onStepCancel != null)
          Padding(
            padding: const EdgeInsets.only(top: IntEspaciado.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onStepCancel != null && currentStep > 0)
                  TextButton(
                    onPressed: onStepCancel,
                    child: const Text('Back'),
                  ),
                if (onStepContinue != null && currentStep < steps.length - 1) ...[
                  const SizedBox(width: IntEspaciado.sm),
                  ElevatedButton(
                    onPressed: onStepContinue,
                    child: const Text('Continue'),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildVertical(Color _active, Color _onActive, Color _onSurfaceMuted) {
    return Column(
      children: [
        ...steps.asMap().entries.map((e) {
          final i = e.key;
          final step = e.value;
          final isCompleted = _isStepCompleted(i);
          final isCurrent = i == currentStep;
          final isLast = i == steps.length - 1;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isCompleted || isCurrent ? _active : IntColores.grey100,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isCurrent || isCompleted ? _active : IntColores.grey300,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: isCompleted
                          ? Icon(Icons.check_rounded, size: 16, color: _onActive)
                          : Text(
                              '${i + 1}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isCurrent ? _onActive : IntColores.grey400,
                              ),
                            ),
                    ),
                  ),
                  if (!isLast)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 2,
                      height: 40,
                      color: isCompleted ? _active : IntColores.grey200,
                    ),
                ],
              ),
              const SizedBox(width: IntEspaciado.md),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: IntEspaciado.xs),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isCurrent || isCompleted
                              ? _active
                              : _onSurfaceMuted,
                        ),
                      ),
                      if (step.subtitle != null)
                        Text(
                          step.subtitle!,
                          style: TextStyle(
                            fontSize: 12,
                            color: _onSurfaceMuted,
                          ),
                        ),
                      if (!isLast) const SizedBox(height: IntEspaciado.xl),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
        if (onStepContinue != null || onStepCancel != null)
          Padding(
            padding: const EdgeInsets.only(top: IntEspaciado.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onStepCancel != null && currentStep > 0)
                  TextButton(
                    onPressed: onStepCancel,
                    child: const Text('Back'),
                  ),
                if (onStepContinue != null && currentStep < steps.length - 1) ...[
                  const SizedBox(width: IntEspaciado.sm),
                  ElevatedButton(
                    onPressed: onStepContinue,
                    child: const Text('Continue'),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntMigaPan
// ─────────────────────────────────────────────────────────────

class IntElementoMigaPan {
  const IntElementoMigaPan({
    required this.label,
    this.onTap,
    this.icon,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
}

class IntMigaPan extends StatelessWidget {
  const IntMigaPan({
    super.key,
    required this.items,
    this.separator = '/',
    this.activeColor,
    this.maxItems,
  });

  final List<IntElementoMigaPan> items;
  final String separator;
  final Color? activeColor;

  /// When set, truncates middle items with "..." if items.length > maxItems.
  /// Must be >= 2 to show at least the first and last item.
  final int? maxItems;

  @override
  Widget build(BuildContext context) {
    final onSurfaceMuted = Theme.of(context).colorScheme.onSurface.withOpacity(0.6);
    final widgets = <Widget>[];

    // Determine which items to display, truncating middle items if maxItems is set.
    final List<IntElementoMigaPan> displayItems;
    final bool truncated;

    if (maxItems != null && maxItems! >= 2 && items.length > maxItems!) {
      // Show first (maxItems ~/ 2) items, then "...", then last items
      final firstCount = (maxItems! / 2).ceil();
      final lastCount = maxItems! - firstCount;
      displayItems = [
        ...items.sublist(0, firstCount),
        ...items.sublist(items.length - lastCount),
      ];
      truncated = true;
    } else {
      displayItems = items;
      truncated = false;
    }

    // Track position within displayItems for separator insertion
    final truncationInsertIndex = truncated ? (maxItems! / 2).ceil() : -1;

    for (int i = 0; i < displayItems.length; i++) {
      final item = displayItems[i];
      // Determine if this is the last visible item (maps to last real item)
      final isLast = i == displayItems.length - 1;

      // Insert the ellipsis before the second half of items
      if (truncated && i == truncationInsertIndex) {
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: IntEspaciado.xs),
          child: Text(
            separator,
            style: const TextStyle(fontSize: 13, color: IntColores.grey300),
          ),
        ));
        widgets.add(
          Text(
            '...',
            style: TextStyle(fontSize: 13, color: onSurfaceMuted),
          ),
        );
      }

      if (item.icon != null) {
        widgets.add(Icon(item.icon, size: 14, color: onSurfaceMuted));
        widgets.add(const SizedBox(width: 4));
      }

      widgets.add(
        GestureDetector(
          onTap: item.onTap,
          child: Text(
            item.label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isLast ? FontWeight.w600 : FontWeight.w400,
              color: isLast
                  ? (activeColor ?? Theme.of(context).colorScheme.primary)
                  : onSurfaceMuted,
              decoration: item.onTap != null && !isLast
                  ? TextDecoration.underline
                  : null,
            ),
          ),
        ),
      );

      if (!isLast) {
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: IntEspaciado.xs),
          child: Text(
            separator,
            style: const TextStyle(fontSize: 13, color: IntColores.grey300),
          ),
        ));
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widgets,
      ),
    );
  }
}
