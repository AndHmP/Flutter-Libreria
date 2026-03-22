import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Tipos de logo disponibles en la librería.
enum IntLogoTipo {
  supervisores,
  vendedores,
  transportistas,
}

/// Widget que muestra los logos SVG de la librería.
///
/// Uso:
/// ```dart
/// IntLogo(tipo: IntLogoTipo.supervisores, width: 120)
/// IntLogo(tipo: IntLogoTipo.vendedores, height: 80)
/// IntLogo(tipo: IntLogoTipo.transportistas)
/// ```
class IntLogo extends StatelessWidget {
  const IntLogo({
    super.key,
    required this.tipo,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.colorFilter,
  });

  final IntLogoTipo tipo;
  final double? width;
  final double? height;
  final BoxFit fit;
  final ColorFilter? colorFilter;

  String get _assetPath {
    switch (tipo) {
      case IntLogoTipo.supervisores:
        return 'assets/logos/supervisores.svg';
      case IntLogoTipo.vendedores:
        return 'assets/logos/vendedores.svg';
      case IntLogoTipo.transportistas:
        return 'assets/logos/transportistas.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _assetPath,
      package: 'flutter_ui_lib',
      width: width,
      height: height,
      fit: fit,
      colorFilter: colorFilter,
    );
  }
}
