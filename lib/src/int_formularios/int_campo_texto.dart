import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../int_tema/int_colores.dart';
import '../int_tema/int_espaciado.dart';

// ─────────────────────────────────────────────────────────────
// IntCampoTexto
// ─────────────────────────────────────────────────────────────

class IntCampoTexto extends StatelessWidget {
  const IntCampoTexto({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.onTap,
    this.textInputAction,
    this.validator,
    this.onSaved,
    this.autovalidateMode,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.minLines,
    this.contentPadding,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final AutovalidateMode? autovalidateMode;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final int? minLines;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      enabled: enabled,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      autofocus: autofocus,
      readOnly: readOnly,
      onTap: onTap,
      textInputAction: textInputAction,
      validator: validator,
      onSaved: onSaved,
      autovalidateMode: autovalidateMode,
      textAlign: textAlign,
      textCapitalization: textCapitalization,
      minLines: minLines,
      style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 18) : null,
        suffixIcon: suffixIcon,
        counterText: '',
        contentPadding: contentPadding,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntCampoBusqueda
// ─────────────────────────────────────────────────────────────

class IntCampoBusqueda extends StatefulWidget {
  const IntCampoBusqueda({
    super.key,
    this.controller,
    this.hint = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.autofocus = false,
    this.enabled = true,
    this.focusNode,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool autofocus;
  final bool enabled;
  final FocusNode? focusNode;
  final bool readOnly;

  @override
  State<IntCampoBusqueda> createState() => _IntCampoBusquedaState();
}

class _IntCampoBusquedaState extends State<IntCampoBusqueda> {
  late final TextEditingController _gt_ctrldr;
  bool _gb_hastxt = false;

  @override
  void initState() {
    super.initState();
    _gt_ctrldr = widget.controller ?? TextEditingController();
    _gt_ctrldr.addListener(() {
      final has = _gt_ctrldr.text.isNotEmpty;
      if (has != _gb_hastxt) setState(() => _gb_hastxt = has);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _gt_ctrldr,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      textInputAction: TextInputAction.search,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: const Icon(Icons.search, size: 18, color: IntColores.grey400),
        suffixIcon: _gb_hastxt
            ? IconButton(
                icon: const Icon(Icons.close, size: 16, color: IntColores.grey400),
                onPressed: () {
                  _gt_ctrldr.clear();
                  widget.onClear?.call();
                },
              )
            : null,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntCampoClave
// ─────────────────────────────────────────────────────────────

class IntCampoClave extends StatefulWidget {
  const IntCampoClave({
    super.key,
    this.controller,
    this.label,
    this.hint = 'Enter password',
    this.helperText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.textInputAction,
    this.showStrengthIndicator = false,
    this.validator,
    this.onSaved,
    this.maxLength,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final bool showStrengthIndicator;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final int? maxLength;

  @override
  State<IntCampoClave> createState() => _IntCampoClaveState();
}

class _IntCampoClaveState extends State<IntCampoClave> {
  bool _gb_obscre = true;
  late final TextEditingController _gt_ctrldr;
  double _gd_fuerzz = 0;

  @override
  void initState() {
    super.initState();
    _gt_ctrldr = widget.controller ?? TextEditingController();
    if (widget.showStrengthIndicator) {
      _gt_ctrldr.addListener(_calcStrength);
    }
  }

  void _calcStrength() {
    final text = _gt_ctrldr.text;
    if (text.isEmpty) {
      setState(() => _gd_fuerzz = 0);
      return;
    }
    double s = 0;
    if (text.length >= 6) s += 0.2;
    if (text.length >= 10) s += 0.1;
    if (RegExp(r'[A-Z]').hasMatch(text)) s += 0.2;
    if (RegExp(r'[a-z]').hasMatch(text)) s += 0.1;
    if (RegExp(r'[0-9]').hasMatch(text)) s += 0.2;
    if (RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:,.<>?]').hasMatch(text)) s += 0.2;
    setState(() => _gd_fuerzz = s.clamp(0.0, 1.0));
  }

  Color get _gc_fuerzc {
    if (_gd_fuerzz <= 0.3) return IntColores.error;
    if (_gd_fuerzz <= 0.6) return IntColores.warning;
    return IntColores.success;
  }

  String get _gs_fuerzl {
    if (_gd_fuerzz <= 0.3) return 'Weak';
    if (_gd_fuerzz <= 0.6) return 'Medium';
    return 'Strong';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        IntCampoTexto(
          controller: _gt_ctrldr,
          label: widget.label,
          hint: widget.hint,
          helperText: widget.helperText,
          errorText: widget.errorText,
          obscureText: _gb_obscre,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          enabled: widget.enabled,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          textInputAction: widget.textInputAction,
          prefixIcon: Icons.lock_outline,
          suffixIcon: IconButton(
            icon: Icon(
              _gb_obscre ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              size: 18,
              color: IntColores.grey400,
            ),
            onPressed: () => setState(() => _gb_obscre = !_gb_obscre),
          ),
          validator: widget.validator,
          onSaved: widget.onSaved,
          maxLength: widget.maxLength,
        ),
        if (widget.showStrengthIndicator && _gt_ctrldr.text.isNotEmpty) ...[
          const SizedBox(height: IntEspaciado.sm),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(IntRadio.full),
                  child: LinearProgressIndicator(
                    value: _gd_fuerzz,
                    backgroundColor: IntColores.grey200,
                    valueColor: AlwaysStoppedAnimation<Color>(_gc_fuerzc),
                    minHeight: 4,
                  ),
                ),
              ),
              const SizedBox(width: IntEspaciado.sm),
              Text(
                _gs_fuerzl,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _gc_fuerzc,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntDesplegable (fixed: removed duplicate errorText display)
// ─────────────────────────────────────────────────────────────

class IntDesplegable<T> extends StatefulWidget {
  const IntDesplegable({
    super.key,
    required this.items,
    required this.itemLabel,
    this.value,
    this.onChanged,
    this.label,
    this.hint = 'Select an option',
    this.errorText,
    this.enabled = true,
    this.prefixIcon,
    this.searchable = false,
    this.draggable = false,
    this.validator,
    this.focusNode,
    this.readOnly = false,
  });

  final List<T> items;
  final String Function(T) itemLabel;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String hint;
  final String? errorText;
  final bool enabled;
  final IconData? prefixIcon;
  final bool searchable;

  /// Si es true, las opciones se abren en un panel flotante arrastrable.
  final bool draggable;

  final String? Function(T?)? validator;
  final FocusNode? focusNode;
  final bool readOnly;

  @override
  State<IntDesplegable<T>> createState() => _IntDesplegableState<T>();
}

class _IntDesplegableState<T> extends State<IntDesplegable<T>> {
  String _gs_buscqr = '';
  OverlayEntry? _go_overlay;

  List<T> get _gl_filitm {
    if (!widget.searchable || _gs_buscqr.isEmpty) return widget.items;
    return widget.items
        .where((item) => widget.itemLabel(item).toLowerCase().contains(_gs_buscqr.toLowerCase()))
        .toList();
  }

  void _showDraggablePanel() {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _go_overlay = OverlayEntry(
      builder: (_) => _DraggableDropdownPanel<T>(
        items: _gl_filitm,
        itemLabel: widget.itemLabel,
        value: widget.value,
        initialOffset: Offset(offset.dx, offset.dy + size.height + 4),
        width: size.width,
        onSelected: (item) {
          widget.onChanged?.call(item);
          _closeDraggablePanel();
        },
        onClose: _closeDraggablePanel,
      ),
    );
    Overlay.of(context).insert(_go_overlay!);
  }

  void _closeDraggablePanel() {
    _go_overlay?.remove();
    _go_overlay = null;
  }

  @override
  void dispose() {
    _closeDraggablePanel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onSurfaceMuted = Theme.of(context).colorScheme.onSurface.withOpacity(0.6);

    if (widget.draggable) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) ...[
            Text(widget.label!, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: onSurfaceMuted)),
            const SizedBox(height: IntEspaciado.xs),
          ],
          GestureDetector(
            onTap: (widget.enabled && !widget.readOnly) ? _showDraggablePanel : null,
            child: InputDecorator(
              decoration: InputDecoration(
                errorText: widget.errorText,
                prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, size: 18) : null,
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: IntColores.grey400),
              ),
              child: Text(
                widget.value != null ? widget.itemLabel(widget.value as T) : widget.hint,
                style: TextStyle(
                  fontSize: 14,
                  color: widget.value != null
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: onSurfaceMuted)),
          const SizedBox(height: IntEspaciado.xs),
        ],
        DropdownButtonFormField<T>(
          value: widget.value,
          onChanged: (widget.enabled && !widget.readOnly) ? widget.onChanged : null,
          focusNode: widget.focusNode,
          validator: widget.validator,
          decoration: InputDecoration(
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, size: 18) : null,
          ),
          hint: Text(widget.hint, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4), fontSize: 14)),
          selectedItemBuilder: widget.value != null
              ? (_) => widget.items
                  .map((item) => Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.itemLabel(item),
                          style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList()
              : null,
          items: _gl_filitm
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(widget.itemLabel(item), style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface)),
                  ))
              .toList(),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: IntColores.grey400),
          isExpanded: true,
          dropdownColor: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(IntRadio.md),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntCasilla
// ─────────────────────────────────────────────────────────────

class IntCasilla extends StatelessWidget {
  const IntCasilla({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.description,
    this.activeColor,
    this.enabled = true,
    this.tristate = false,
    this.errorText,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;
  final String? label;
  final String? description;
  final Color? activeColor;
  final bool enabled;
  final bool tristate;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final color = enabled ? Theme.of(context).colorScheme.onSurface : IntColores.textDisabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: enabled ? () => onChanged(!value) : null,
          borderRadius: BorderRadius.circular(IntRadio.sm),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: IntEspaciado.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: value,
                    onChanged: enabled ? onChanged : null,
                    activeColor: activeColor ?? Theme.of(context).colorScheme.primary,
                    tristate: tristate,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                if (label != null) ...[
                  const SizedBox(width: IntEspaciado.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: color,
                          ),
                        ),
                        if (description != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              description!,
                              style: TextStyle(
                                fontSize: 12,
                                color: enabled ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6) : IntColores.textDisabled,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 28, top: IntEspaciado.xs),
            child: Text(
              errorText!,
              style: TextStyle(fontSize: 12, color: IntColores.error),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntGrupoCasillas
// ─────────────────────────────────────────────────────────────

class IntGrupoCasillas<T> extends StatelessWidget {
  const IntGrupoCasillas({
    super.key,
    required this.options,
    required this.optionLabel,
    required this.values,
    required this.onChanged,
    this.activeColor,
    this.direction = Axis.vertical,
    this.optionDescription,
    this.label,
    this.errorText,
    this.enabled = true,
  });

  final List<T> options;
  final String Function(T) optionLabel;
  final String Function(T)? optionDescription;
  final Set<T> values;
  final ValueChanged<Set<T>> onChanged;
  final Color? activeColor;
  final Axis direction;
  final String? label;
  final String? errorText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final items = options.map((option) {
      final selected = values.contains(option);
      return IntCasilla(
        value: selected,
        label: optionLabel(option),
        description: optionDescription?.call(option),
        activeColor: activeColor,
        enabled: enabled,
        onChanged: (_) {
          final updated = Set<T>.from(values);
          if (selected) {
            updated.remove(option);
          } else {
            updated.add(option);
          }
          onChanged(updated);
        },
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: IntEspaciado.xs),
            child: Text(
              label!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        direction == Axis.vertical
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: items)
            : Wrap(spacing: IntEspaciado.lg, children: items),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: IntEspaciado.xs),
            child: Text(
              errorText!,
              style: TextStyle(fontSize: 12, color: IntColores.error),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// AppRadio
// ─────────────────────────────────────────────────────────────

class IntGrupoRadio<T> extends StatelessWidget {
  const IntGrupoRadio({
    super.key,
    required this.options,
    required this.optionLabel,
    required this.value,
    required this.onChanged,
    this.direction = Axis.vertical,
    this.activeColor,
    this.label,
    this.errorText,
    this.enabled = true,
  });

  final List<T> options;
  final String Function(T) optionLabel;
  final T value;
  final ValueChanged<T> onChanged;
  final Axis direction;
  final Color? activeColor;
  final String? label;
  final String? errorText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final items = options
        .map(
          (option) => InkWell(
            onTap: enabled ? () => onChanged(option) : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<T>(
                  value: option,
                  // ignore: deprecated_member_use
                  groupValue: value,
                  // ignore: deprecated_member_use
                  onChanged: enabled ? (v) => v != null ? onChanged(v) : null : null,
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (!enabled) return IntColores.textDisabled;
                    if (states.contains(WidgetState.selected)) {
                      return activeColor ?? Theme.of(context).colorScheme.primary;
                    }
                    return IntColores.grey400;
                  }),
                ),
                Text(
                  optionLabel(option),
                  style: TextStyle(
                    fontSize: 14,
                    color: enabled
                        ? Theme.of(context).colorScheme.onSurface
                        : IntColores.textDisabled,
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: IntEspaciado.xs),
            child: Text(
              label!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        direction == Axis.vertical
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: items)
            : Wrap(spacing: IntEspaciado.lg, children: items),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: IntEspaciado.xs),
            child: Text(
              errorText!,
              style: TextStyle(fontSize: 12, color: IntColores.error),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntInterruptor
// ─────────────────────────────────────────────────────────────

enum IntInterruptorTamano { sm, md }

class IntInterruptor extends StatelessWidget {
  const IntInterruptor({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.description,
    this.activeColor,
    this.enabled = true,
    this.size = IntInterruptorTamano.md,
    this.focusNode,
    this.autofocus = false,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  final String? description;
  final Color? activeColor;
  final bool enabled;
  final IntInterruptorTamano size;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final textColor = enabled ? Theme.of(context).colorScheme.onSurface : IntColores.textDisabled;
    final descColor = enabled ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6) : IntColores.textDisabled;
    final trackColor = activeColor ?? Theme.of(context).colorScheme.primary;

    final switchWidget = Transform.scale(
      scale: size == IntInterruptorTamano.sm ? 0.75 : 1.0,
      child: Switch(
        value: value,
        onChanged: enabled ? onChanged : null,
        focusNode: focusNode,
        autofocus: autofocus,
        thumbColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return trackColor;
          return IntColores.grey300;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );

    if (label == null) return switchWidget;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label!,
                style: TextStyle(
                  fontSize: size == IntInterruptorTamano.sm ? 13 : 14,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              if (description != null)
                Text(
                  description!,
                  style: TextStyle(fontSize: 12, color: descColor),
                ),
            ],
          ),
        ),
        switchWidget,
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// _DraggableDropdownPanel (panel flotante arrastrable)
// ─────────────────────────────────────────────────────────────

class _DraggableDropdownPanel<T> extends StatefulWidget {
  const _DraggableDropdownPanel({
    required this.items,
    required this.itemLabel,
    required this.value,
    required this.initialOffset,
    required this.width,
    required this.onSelected,
    required this.onClose,
  });

  final List<T> items;
  final String Function(T) itemLabel;
  final T? value;
  final Offset initialOffset;
  final double width;
  final ValueChanged<T> onSelected;
  final VoidCallback onClose;

  @override
  State<_DraggableDropdownPanel<T>> createState() => _DraggableDropdownPanelState<T>();
}

class _DraggableDropdownPanelState<T> extends State<_DraggableDropdownPanel<T>> {
  late Offset _go_offset;

  @override
  void initState() {
    super.initState();
    _go_offset = widget.initialOffset;
  }

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final primary = Theme.of(context).colorScheme.primary;
    final divider = Theme.of(context).dividerColor;

    return Stack(
      children: [
        // Fondo semitransparente para cerrar al tocar fuera
        GestureDetector(
          onTap: widget.onClose,
          child: Container(color: Colors.transparent, width: double.infinity, height: double.infinity),
        ),
        Positioned(
          left: _go_offset.dx,
          top: _go_offset.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() => _go_offset += details.delta);
            },
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(IntRadio.md),
              color: surface,
              child: Container(
                width: widget.width.clamp(200, 400),
                constraints: const BoxConstraints(maxHeight: 300),
                decoration: BoxDecoration(
                  border: Border.all(color: divider),
                  borderRadius: BorderRadius.circular(IntRadio.md),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Barra de arrastre
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: IntEspaciado.md, vertical: IntEspaciado.sm),
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.08),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(IntRadio.md)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.drag_indicator, size: 16, color: onSurface.withOpacity(0.4)),
                          const SizedBox(width: 4),
                          Text('Arrastra para mover', style: TextStyle(fontSize: 11, color: onSurface.withOpacity(0.4))),
                          const Spacer(),
                          GestureDetector(
                            onTap: widget.onClose,
                            child: Icon(Icons.close, size: 16, color: onSurface.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: divider),
                    // Lista de opciones
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          final item = widget.items[index];
                          final isSelected = widget.value != null && widget.itemLabel(widget.value as T) == widget.itemLabel(item);
                          return InkWell(
                            onTap: () => widget.onSelected(item),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: IntEspaciado.lg, vertical: IntEspaciado.md),
                              color: isSelected ? primary.withOpacity(0.1) : null,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.itemLabel(item),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isSelected ? primary : onSurface,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  if (isSelected) Icon(Icons.check, size: 16, color: primary),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntSelectorFecha
// ─────────────────────────────────────────────────────────────

class IntSelectorFecha extends StatefulWidget {
  const IntSelectorFecha({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.label,
    this.hint = 'Select date',
    this.onDateSelected,
    this.enabled = true,
    this.errorText,
    this.dateFormat,
    this.controller,
    this.validator,
  });

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? label;
  final String hint;
  final ValueChanged<DateTime>? onDateSelected;
  final bool enabled;
  final String? errorText;

  /// Custom date format string. Supported tokens: dd, MM, yyyy.
  /// Default is 'dd/MM/yyyy'.
  final String? dateFormat;

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<IntSelectorFecha> createState() => _IntSelectorFechaState();
}

class _IntSelectorFechaState extends State<IntSelectorFecha> {
  DateTime? _go_selctd;
  late final TextEditingController _gt_ctrldr;

  @override
  void initState() {
    super.initState();
    _gt_ctrldr = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _gt_ctrldr.dispose();
    }
    super.dispose();
  }

  String _format(DateTime dt) {
    final pattern = widget.dateFormat ?? 'dd/MM/yyyy';
    return pattern
        .replaceAll('dd', dt.day.toString().padLeft(2, '0'))
        .replaceAll('MM', dt.month.toString().padLeft(2, '0'))
        .replaceAll('yyyy', dt.year.toString());
  }

  Future<void> _pick() async {
    if (!widget.enabled) return;
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: _go_selctd ?? widget.initialDate ?? now,
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(primary: Theme.of(context).colorScheme.primary),
        ),
        child: child!,
      ),
    );
    if (result != null) {
      setState(() {
        _go_selctd = result;
        _gt_ctrldr.text = _format(result);
      });
      widget.onDateSelected?.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_go_selctd != null && _gt_ctrldr.text.isEmpty) {
      _gt_ctrldr.text = _format(_go_selctd!);
    }

    return IntCampoTexto(
      label: widget.label,
      hint: widget.hint,
      controller: _gt_ctrldr,
      readOnly: true,
      enabled: widget.enabled,
      onTap: _pick,
      suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
      errorText: widget.errorText,
      validator: widget.validator,
    );
  }
}
