import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../int_tema/int_colores.dart';
import '../int_tema/int_espaciado.dart';

// ─────────────────────────────────────────────────────────────
// IntCampoOtp
// Single-character-per-box input for verification codes (SMS,
// phone codes, 2FA, etc.).
// ─────────────────────────────────────────────────────────────

class IntCampoOtp extends StatefulWidget {
  const IntCampoOtp({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.obscure = false,
    this.autoFocus = true,
    this.fieldWidth = 48,
    this.fieldHeight = 56,
    this.activeColor,
    this.errorText,
    this.keyboardType = TextInputType.number,
    this.enabled = true,
    this.readOnly = false,
    this.borderRadius,
    this.spacing,
  });

  /// Number of input boxes.
  final int length;

  /// Called when all boxes are filled.
  final ValueChanged<String>? onCompleted;

  /// Called every time the value changes.
  final ValueChanged<String>? onChanged;

  /// Mask characters with bullets.
  final bool obscure;

  /// Focus the first field on mount.
  final bool autoFocus;

  /// Width of each individual box.
  final double fieldWidth;

  /// Height of each individual box.
  final double fieldHeight;

  /// Border color when a box is focused. Defaults to [Theme.of(context).colorScheme.primary].
  final Color? activeColor;

  /// Error message displayed below the fields.
  final String? errorText;

  /// Keyboard type (default: number).
  final TextInputType keyboardType;

  /// Whether the OTP fields are enabled. When false all fields are disabled.
  final bool enabled;

  /// Whether the OTP fields are read-only. Shows values but can't edit.
  final bool readOnly;

  /// Custom corner radius for each OTP box.
  final double? borderRadius;

  /// Space between OTP boxes. Defaults to [IntEspaciado.sm].
  final double? spacing;

  @override
  State<IntCampoOtp> createState() => _IntCampoOtpState();
}

class _IntCampoOtpState extends State<IntCampoOtp> {
  late final List<TextEditingController> _gl_ctrlrs;
  late final List<FocusNode> _gl_fcsnds;

  @override
  void initState() {
    super.initState();
    _gl_ctrlrs = List.generate(widget.length, (_) => TextEditingController());
    _gl_fcsnds = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _gl_ctrlrs) {
      c.dispose();
    }
    for (final f in _gl_fcsnds) {
      f.dispose();
    }
    super.dispose();
  }

  String get _gs_curval =>
      _gl_ctrlrs.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      // Handle paste – distribute characters across fields.
      final chars = value.characters.toList();
      for (int i = 0; i < chars.length && (index + i) < widget.length; i++) {
        _gl_ctrlrs[index + i].text = chars[i];
      }
      final nextIndex = (index + chars.length).clamp(0, widget.length - 1);
      _gl_fcsnds[nextIndex].requestFocus();
    } else if (value.isNotEmpty) {
      // Single character entered – move to the next field.
      if (index < widget.length - 1) {
        _gl_fcsnds[index + 1].requestFocus();
      }
    }

    final code = _gs_curval;
    widget.onChanged?.call(code);
    if (code.length == widget.length) {
      widget.onCompleted?.call(code);
    }
  }

  void _onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _gl_ctrlrs[index].text.isEmpty &&
        index > 0) {
      _gl_ctrlrs[index - 1].clear();
      _gl_fcsnds[index - 1].requestFocus();
      widget.onChanged?.call(_gs_curval);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;
    final inputTheme = Theme.of(context).inputDecorationTheme;
    final activeColor = widget.activeColor ?? Theme.of(context).colorScheme.primary;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final resolvedBorderRadius = widget.borderRadius ?? IntRadio.md;
    final resolvedSpacing = widget.spacing ?? IntEspaciado.sm;
    final borderRadius = BorderRadius.circular(resolvedBorderRadius);

    // Tomar los colores de borde del tema del input
    final enabledBorderColor = (inputTheme.enabledBorder as OutlineInputBorder?)?.borderSide.color ?? IntColores.border;
    final disabledBorderColor = (inputTheme.disabledBorder as OutlineInputBorder?)?.borderSide.color ?? enabledBorderColor;
    final fillColor = inputTheme.fillColor ?? Theme.of(context).colorScheme.surface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.length, (i) {
            return Padding(
              padding: EdgeInsets.only(
                right: i < widget.length - 1 ? resolvedSpacing : 0,
              ),
              child: SizedBox(
                width: widget.fieldWidth,
                height: widget.fieldHeight,
                child: KeyboardListener(
                  focusNode: FocusNode(),
                  onKeyEvent: (event) => _onKeyEvent(i, event),
                  child: TextField(
                    controller: _gl_ctrlrs[i],
                    focusNode: _gl_fcsnds[i],
                    autofocus: widget.autoFocus && i == 0,
                    textAlign: TextAlign.center,
                    keyboardType: widget.keyboardType,
                    obscureText: widget.obscure,
                    maxLength: 1,
                    enabled: widget.enabled,
                    readOnly: widget.readOnly,
                    onChanged: (v) => _onChanged(i, v),
                    inputFormatters: widget.keyboardType == TextInputType.number
                        ? [FilteringTextInputFormatter.digitsOnly]
                        : null,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: onSurface,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: fillColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide: BorderSide(
                          color: hasError ? IntColores.error : enabledBorderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide: BorderSide(
                          color: hasError ? IntColores.error : activeColor,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide: const BorderSide(color: IntColores.error),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide: BorderSide(
                          color: disabledBorderColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        if (hasError) ...[
          const SizedBox(height: IntEspaciado.sm),
          Center(
            child: Text(
              widget.errorText!,
              style: const TextStyle(fontSize: 12, color: IntColores.error),
            ),
          ),
        ],
      ],
    );
  }
}
