import 'package:flutter/material.dart';
import '../int_tema/int_colores.dart';
import '../int_tema/int_espaciado.dart';

// ─────────────────────────────────────────────────────────────
// Column definition
// ─────────────────────────────────────────────────────────────

class IntColumnaTabla<T> {
  const IntColumnaTabla({
    required this.key,
    required this.label,
    required this.cellBuilder,
    this.width,
    this.sortable = false,
    this.alignment = Alignment.centerLeft,
  });

  final String key;
  final String label;
  final Widget Function(T row) cellBuilder;
  final double? width;
  final bool sortable;
  final Alignment alignment;
}

// ─────────────────────────────────────────────────────────────
// IntTabla
// ─────────────────────────────────────────────────────────────

class IntTabla<T> extends StatelessWidget {
  const IntTabla({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
    this.emptyMessage = 'No data available',
    this.isLoading = false,
    this.showBorder = true,
    this.stripedRows = true,
    this.stickyHeader = true,
    this.rowHeight = 52,
    this.headerHeight = 44,
    this.dense = false,
    this.selectable = false,
    this.selectedRows,
    this.onRowSelected,
    this.horizontalScroll = false,
  });

  final List<IntColumnaTabla<T>> columns;
  final List<T> rows;
  final VoidCallback? Function(T row)? onRowTap;
  final String emptyMessage;
  final bool isLoading;
  final bool showBorder;
  final bool stripedRows;
  final bool stickyHeader;
  final double rowHeight;
  final double headerHeight;

  /// Reduces row height when true.
  final bool dense;

  /// Enables row selection when true.
  final bool selectable;

  /// Indices of currently selected rows.
  final Set<int>? selectedRows;

  /// Callback when a row is selected or deselected.
  final void Function(int index, bool selected)? onRowSelected;

  /// Enables horizontal scrolling when true.
  final bool horizontalScroll;

  @override
  Widget build(BuildContext context) {
    final dividerColor = Theme.of(context).dividerColor;
    final onSurfaceMuted = Theme.of(context).colorScheme.onSurface.withOpacity(0.6);
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final effectiveRowHeight = dense ? rowHeight * 0.7 : rowHeight;
    final effectiveHeaderHeight = dense ? headerHeight * 0.8 : headerHeight;

    Widget buildContent() {
      return Column(
        children: [
          // Header
          Container(
            height: effectiveHeaderHeight,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                if (selectable)
                  SizedBox(
                    width: dense ? 36 : 48,
                    child: Center(
                      child: Checkbox(
                        value: selectedRows != null &&
                            rows.isNotEmpty &&
                            selectedRows!.length == rows.length,
                        tristate: true,
                        onChanged: onRowSelected != null
                            ? (val) {
                                final selectAll = val == true;
                                for (int i = 0; i < rows.length; i++) {
                                  onRowSelected!(i, selectAll);
                                }
                              }
                            : null,
                      ),
                    ),
                  ),
                ...columns.map((col) => _buildHeaderCell(col, onSurfaceMuted)),
              ],
            ),
          ),
          const Divider(height: 1),
          // Body
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(IntEspaciado.xl3),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (rows.isEmpty)
            Padding(
              padding: const EdgeInsets.all(IntEspaciado.xl3),
              child: Center(
                child: Text(
                  emptyMessage,
                  style: TextStyle(fontSize: 14, color: onSurfaceMuted),
                ),
              ),
            )
          else
            ...rows.asMap().entries.map((entry) {
              final i = entry.key;
              final row = entry.value;
              return _buildRow(context, row, i, surfaceColor, effectiveRowHeight);
            }),
        ],
      );
    }

    final content = buildContent();

    return Container(
      decoration: showBorder
          ? BoxDecoration(
              border: Border.all(color: dividerColor),
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      clipBehavior: Clip.antiAlias,
      child: horizontalScroll
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicWidth(child: content),
            )
          : content,
    );
  }

  Widget _buildHeaderCell(IntColumnaTabla<T> col, Color onSurfaceMuted) {
    return Expanded(
      flex: col.width != null ? 0 : 1,
      child: SizedBox(
        width: col.width,
        child: Align(
          alignment: col.alignment,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dense ? IntEspaciado.md : IntEspaciado.lg,
            ),
            child: Text(
              col.label,
              style: TextStyle(
                fontSize: dense ? 11 : 12,
                fontWeight: FontWeight.w600,
                color: onSurfaceMuted,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, T row, int index, Color surfaceColor, double effectiveRowHeight) {
    final isEven = index % 2 == 0;
    final isSelected = selectedRows?.contains(index) ?? false;
    final activeColor = Theme.of(context).colorScheme.primary;

    return InkWell(
      onTap: onRowTap?.call(row),
      child: Container(
        height: effectiveRowHeight,
        color: isSelected
            ? activeColor.withOpacity(0.08)
            : stripedRows && !isEven
                ? Theme.of(context).colorScheme.surfaceContainerHighest
                : surfaceColor,
        child: Row(
          children: [
            if (selectable)
              SizedBox(
                width: dense ? 36 : 48,
                child: Center(
                  child: Checkbox(
                    value: isSelected,
                    onChanged: onRowSelected != null
                        ? (val) => onRowSelected!(index, val ?? false)
                        : null,
                  ),
                ),
              ),
            ...columns.map((col) {
              return Expanded(
                flex: col.width != null ? 0 : 1,
                child: SizedBox(
                  width: col.width,
                  child: Align(
                    alignment: col.alignment,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: dense ? IntEspaciado.md : IntEspaciado.lg,
                      ),
                      child: col.cellBuilder(row),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// IntTablaOrdenable
// ─────────────────────────────────────────────────────────────

class IntTablaOrdenable<T> extends StatefulWidget {
  const IntTablaOrdenable({
    super.key,
    required this.columns,
    required this.rows,
    required this.sortRow,
    this.onRowTap,
    this.emptyMessage = 'No data available',
    this.isLoading = false,
    this.defaultSortKey,
    this.defaultSortAscending = true,
  });

  final List<IntColumnaTabla<T>> columns;
  final List<T> rows;
  final int Function(T a, T b, String columnKey, bool ascending) sortRow;
  final VoidCallback? Function(T row)? onRowTap;
  final String emptyMessage;
  final bool isLoading;

  /// Initial sort column key.
  final String? defaultSortKey;

  /// Default sort direction (true = ascending).
  final bool defaultSortAscending;

  @override
  State<IntTablaOrdenable<T>> createState() => _IntTablaOrdenableState<T>();
}

class _IntTablaOrdenableState<T> extends State<IntTablaOrdenable<T>> {
  String? _gs_srtkey;
  bool _gb_ascend = true;
  late List<T> _gl_sorted;

  @override
  void initState() {
    super.initState();
    _gs_srtkey = widget.defaultSortKey;
    _gb_ascend = widget.defaultSortAscending;
    _gl_sorted = List.from(widget.rows);
    if (_gs_srtkey != null) _applySort();
  }

  @override
  void didUpdateWidget(covariant IntTablaOrdenable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _gl_sorted = List.from(widget.rows);
    if (_gs_srtkey != null) _applySort();
  }

  void _applySort() {
    _gl_sorted.sort((a, b) => widget.sortRow(a, b, _gs_srtkey!, _gb_ascend));
  }

  void _onHeaderTap(String key) {
    setState(() {
      if (_gs_srtkey == key) {
        _gb_ascend = !_gb_ascend;
      } else {
        _gs_srtkey = key;
        _gb_ascend = true;
      }
      _applySort();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dividerColor = Theme.of(context).dividerColor;
    final onSurfaceMuted = Theme.of(context).colorScheme.onSurface.withOpacity(0.6);
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Header with sort indicators
          Container(
            height: 44,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              children: widget.columns.map((col) {
                final isSorted = _gs_srtkey == col.key;
                return Expanded(
                  child: InkWell(
                    onTap: col.sortable ? () => _onHeaderTap(col.key) : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: IntEspaciado.lg),
                      child: Row(
                        children: [
                          Text(
                            col.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSorted ? Theme.of(context).colorScheme.primary : onSurfaceMuted,
                              letterSpacing: 0.3,
                            ),
                          ),
                          if (col.sortable) ...[
                            const SizedBox(width: 4),
                            Icon(
                              isSorted
                                  ? (_gb_ascend
                                      ? Icons.arrow_upward_rounded
                                      : Icons.arrow_downward_rounded)
                                  : Icons.unfold_more_rounded,
                              size: 14,
                              color: isSorted ? Theme.of(context).colorScheme.primary : IntColores.grey300,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1),
          if (widget.isLoading)
            const Padding(
              padding: EdgeInsets.all(IntEspaciado.xl3),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_gl_sorted.isEmpty)
            Padding(
              padding: const EdgeInsets.all(IntEspaciado.xl3),
              child: Center(
                child: Text(
                  widget.emptyMessage,
                  style: TextStyle(fontSize: 14, color: onSurfaceMuted),
                ),
              ),
            )
          else
            ..._gl_sorted.asMap().entries.map((entry) {
              final isEven = entry.key % 2 == 0;
              final row = entry.value;
              return InkWell(
                onTap: widget.onRowTap?.call(row),
                child: Container(
                  height: 52,
                  color: !isEven ? Theme.of(context).colorScheme.surfaceContainerHighest : surfaceColor,
                  child: Row(
                    children: widget.columns.map((col) {
                      return Expanded(
                        child: Align(
                          alignment: col.alignment,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: IntEspaciado.lg,
                            ),
                            child: col.cellBuilder(row),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
