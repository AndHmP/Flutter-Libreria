import 'package:flutter/material.dart';
import '../int_tema/int_colores.dart';
import '../int_tema/int_espaciado.dart';

// ─────────────────────────────────────────────────────────────
// IntNodoArbol model
// ─────────────────────────────────────────────────────────────

class IntNodoArbol {
  IntNodoArbol({
    required this.id,
    required this.label,
    this.children = const [],
    this.icon,
    this.iconColor,
    this.isExpanded = false,
    this.isSelected = false,
    this.data,
  });

  final String id;
  final String label;
  final List<IntNodoArbol> children;
  final IconData? icon;
  final Color? iconColor;
  bool isExpanded;
  bool isSelected;
  final dynamic data;

  bool get hasChildren => children.isNotEmpty;

  IntNodoArbol copyWith({
    bool? isExpanded,
    bool? isSelected,
  }) {
    return IntNodoArbol(
      id: id,
      label: label,
      children: children,
      icon: icon,
      iconColor: iconColor,
      isExpanded: isExpanded ?? this.isExpanded,
      isSelected: isSelected ?? this.isSelected,
      data: data,
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntVistaArbol
// ─────────────────────────────────────────────────────────────

class IntVistaArbol extends StatefulWidget {
  const IntVistaArbol({
    super.key,
    required this.nodes,
    this.onNodeSelected,
    this.onNodeExpanded,
    this.activeColor,
    this.indent = 20.0,
    this.showLines = true,
    this.multiSelect = false,
    this.defaultExpandAll = false,
    this.scrollController,
    this.searchFilter,
    this.expandIcon,
    this.collapseIcon,
  });

  final List<IntNodoArbol> nodes;
  final ValueChanged<IntNodoArbol>? onNodeSelected;
  final ValueChanged<IntNodoArbol>? onNodeExpanded;
  final Color? activeColor;
  final double indent;
  final bool showLines;
  final bool multiSelect;
  final bool defaultExpandAll;

  /// Optional scroll controller for programmatic scroll control.
  final ScrollController? scrollController;

  /// When non-null, filters visible nodes to those whose label contains this string (case-insensitive).
  final String? searchFilter;

  /// Custom icon for the expand indicator.
  final IconData? expandIcon;

  /// Custom icon for the collapse indicator.
  final IconData? collapseIcon;

  @override
  State<IntVistaArbol> createState() => _IntVistaArbolState();
}

class _IntVistaArbolState extends State<IntVistaArbol> {
  late List<IntNodoArbol> _gl_nodoss;
  final Set<String> _ge_expndd = {};
  final Set<String> _ge_selctd = {};

  @override
  void initState() {
    super.initState();
    _gl_nodoss = _deepCopy(widget.nodes);
    if (widget.defaultExpandAll) {
      _expandAll(_gl_nodoss);
    }
  }

  List<IntNodoArbol> _deepCopy(List<IntNodoArbol> nodes) {
    return nodes.map((n) {
      return IntNodoArbol(
        id: n.id,
        label: n.label,
        children: _deepCopy(n.children),
        icon: n.icon,
        iconColor: n.iconColor,
        isExpanded: n.isExpanded,
        isSelected: n.isSelected,
        data: n.data,
      );
    }).toList();
  }

  void _expandAll(List<IntNodoArbol> nodes) {
    for (final node in nodes) {
      if (node.hasChildren) {
        _ge_expndd.add(node.id);
        _expandAll(node.children);
      }
    }
  }

  void _toggleExpand(IntNodoArbol node) {
    setState(() {
      if (_ge_expndd.contains(node.id)) {
        _ge_expndd.remove(node.id);
      } else {
        _ge_expndd.add(node.id);
      }
    });
    widget.onNodeExpanded?.call(node);
  }

  void _toggleSelect(IntNodoArbol node) {
    setState(() {
      if (widget.multiSelect) {
        if (_ge_selctd.contains(node.id)) {
          _ge_selctd.remove(node.id);
        } else {
          _ge_selctd.add(node.id);
        }
      } else {
        _ge_selctd
          ..clear()
          ..add(node.id);
      }
    });
    widget.onNodeSelected?.call(node);
  }

  /// Returns true if a node or any of its descendants match the search filter.
  bool _matchesFilter(IntNodoArbol node) {
    final filter = widget.searchFilter;
    if (filter == null || filter.isEmpty) return true;
    final lowerFilter = filter.toLowerCase();
    if (node.label.toLowerCase().contains(lowerFilter)) return true;
    return node.children.any((child) => _matchesFilter(child));
  }

  /// Filters nodes based on the search filter.
  List<IntNodoArbol> _filterNodes(List<IntNodoArbol> nodes) {
    if (widget.searchFilter == null || widget.searchFilter!.isEmpty) return nodes;
    return nodes.where((node) => _matchesFilter(node)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredNodes = _filterNodes(_gl_nodoss);

    if (widget.scrollController != null) {
      return SingleChildScrollView(
        controller: widget.scrollController,
        child: _buildNodes(filteredNodes, 0),
      );
    }
    return _buildNodes(filteredNodes, 0);
  }

  Widget _buildNodes(List<IntNodoArbol> nodes, int depth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: nodes.map((node) => _buildNode(node, depth)).toList(),
    );
  }

  Widget _buildNode(IntNodoArbol node, int depth) {
    final isExpanded = _ge_expndd.contains(node.id);
    final isSelected = _ge_selctd.contains(node.id);
    final activeColor = widget.activeColor ?? Theme.of(context).colorScheme.primary;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final onSurfaceMuted = onSurface.withOpacity(0.6);

    // When filtering, auto-expand parent nodes that have matching children
    final isFilterActive = widget.searchFilter != null && widget.searchFilter!.isNotEmpty;
    final shouldShowExpanded = isExpanded || (isFilterActive && node.hasChildren && _matchesFilter(node));

    // Determine the expand/collapse icon
    final IconData expandCollapseIcon;
    if (shouldShowExpanded) {
      expandCollapseIcon = widget.collapseIcon ?? Icons.chevron_right_rounded;
    } else {
      expandCollapseIcon = widget.expandIcon ?? Icons.chevron_right_rounded;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Node row
        InkWell(
          onTap: () {
            _toggleSelect(node);
            if (node.hasChildren) _toggleExpand(node);
          },
          borderRadius: BorderRadius.circular(6),
          child: Container(
            height: 36,
            padding: EdgeInsets.only(
              left: IntEspaciado.sm + depth * widget.indent,
              right: IntEspaciado.sm,
            ),
            decoration: BoxDecoration(
              color: isSelected ? activeColor.withOpacity(0.08) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                // Expand/collapse arrow
                SizedBox(
                  width: 20,
                  child: node.hasChildren
                      ? GestureDetector(
                          onTap: () => _toggleExpand(node),
                          child: AnimatedRotation(
                            duration: const Duration(milliseconds: 200),
                            turns: shouldShowExpanded ? 0.25 : 0,
                            child: Icon(
                              expandCollapseIcon,
                              size: 18,
                              color: IntColores.grey500,
                            ),
                          ),
                        )
                      : widget.showLines
                          ? Center(
                              child: Container(
                                width: 1,
                                height: 16,
                                color: IntColores.grey200,
                              ),
                            )
                          : null,
                ),
                const SizedBox(width: IntEspaciado.xs),
                // Node icon
                if (node.icon != null) ...[
                  Icon(
                    node.icon,
                    size: 16,
                    color: isSelected
                        ? activeColor
                        : (node.iconColor ?? onSurfaceMuted),
                  ),
                  const SizedBox(width: IntEspaciado.xs),
                ] else if (node.hasChildren) ...[
                  Icon(
                    shouldShowExpanded ? Icons.folder_open_outlined : Icons.folder_outlined,
                    size: 16,
                    color: isSelected ? activeColor : IntColores.grey400,
                  ),
                  const SizedBox(width: IntEspaciado.xs),
                ] else ...[
                  Icon(
                    Icons.insert_drive_file_outlined,
                    size: 16,
                    color: isSelected ? activeColor : IntColores.grey300,
                  ),
                  const SizedBox(width: IntEspaciado.xs),
                ],
                // Label
                Expanded(
                  child: Text(
                    node.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? activeColor : onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Children (animated)
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: shouldShowExpanded && node.hasChildren
              ? Padding(
                  padding: EdgeInsets.only(
                    left: widget.showLines ? IntEspaciado.sm + depth * widget.indent + 10 : 0,
                  ),
                  child: widget.showLines
                      ? IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: 1,
                                color: IntColores.grey200,
                                margin: const EdgeInsets.symmetric(horizontal: 9),
                              ),
                              Expanded(
                                child: _buildNodes(_filterNodes(node.children), 0),
                              ),
                            ],
                          ),
                        )
                      : _buildNodes(_filterNodes(node.children), depth + 1),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
