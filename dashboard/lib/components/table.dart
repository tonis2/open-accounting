import 'package:flutter/material.dart';

import '../theme.dart';

sealed class ColumnSize {
  const ColumnSize();
}

class FlexColumn extends ColumnSize {
  final int flex;
  const FlexColumn([this.flex = 1]);
}

class FixedColumn extends ColumnSize {
  final double width;
  const FixedColumn(this.width);
}

/// A table column. Set [sortKey] to make the header clickable.
class TableColumn {
  final String header;
  final ColumnSize size;
  final TextAlign align;
  final String? sortKey;
  final EdgeInsets padding;

  const TableColumn({required this.header, this.size = const FlexColumn(), this.align = TextAlign.left, this.sortKey, this.padding = EdgeInsets.zero});
}

class SortState {
  final String key;
  final bool ascending;
  const SortState(this.key, {this.ascending = true});

  SortState toggle(String newKey) => key == newKey ? SortState(key, ascending: !ascending) : SortState(newKey);
}

/// Bordered table with sortable headers. Rows are laid out inline so it can sit inside a
/// scrolling page; keep row counts modest (paginate) rather than relying on virtualisation.
class CustomTable extends StatelessWidget {
  final List<TableColumn> columns;
  final int itemCount;
  final List<Widget> Function(int index) rowBuilder;
  final void Function(int index)? onRowTap;
  final SortState? sort;
  final ValueChanged<SortState>? onSort;
  final Widget? emptyState;
  final Widget? footer;
  final EdgeInsets rowPadding;
  final bool bordered;

  const CustomTable({
    super.key,
    required this.columns,
    required this.itemCount,
    required this.rowBuilder,
    this.onRowTap,
    this.sort,
    this.onSort,
    this.emptyState,
    this.footer,
    this.rowPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.bordered = true,
  });

  Widget _cell(int i, Widget child) {
    final col = columns[i];
    if (col.padding != EdgeInsets.zero) child = Padding(padding: col.padding, child: child);
    final aligned = Align(
      alignment: switch (col.align) {
        TextAlign.right || TextAlign.end => Alignment.centerRight,
        TextAlign.center => Alignment.center,
        _ => Alignment.centerLeft,
      },
      child: child,
    );
    return switch (col.size) {
      FlexColumn(:final flex) => Expanded(flex: flex, child: aligned),
      FixedColumn(:final width) => SizedBox(width: width, child: aligned),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final header = Container(
      padding: rowPadding.copyWith(top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.dividerColor)),
      ),
      child: Row(
        children: [for (var i = 0; i < columns.length; i++) _cell(i, _HeaderCell(column: columns[i], sort: sort, onSort: onSort))],
      ),
    );

    final rows = <Widget>[];
    for (var index = 0; index < itemCount; index++) {
      final cells = rowBuilder(index);
      Widget row = Container(
        padding: rowPadding,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: index == itemCount - 1 && footer == null ? Colors.transparent : theme.colorScheme.outlineVariant)),
        ),
        child: Row(children: [for (var i = 0; i < cells.length; i++) _cell(i, cells[i])]),
      );
      if (onRowTap != null) {
        row = InkWell(onTap: () => onRowTap!(index), hoverColor: theme.colorScheme.surfaceContainerLow, child: row);
      }
      rows.add(row);
    }

    final body = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header,
        if (itemCount == 0 && emptyState != null) Padding(padding: const EdgeInsets.symmetric(vertical: 40), child: emptyState) else ...rows,
        ?footer,
      ],
    );
    if (!bordered) return body;
    return DecoratedBox(
      decoration: panelDecoration(context),
      child: ClipRRect(borderRadius: BorderRadius.circular(10), child: body),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final TableColumn column;
  final SortState? sort;
  final ValueChanged<SortState>? onSort;

  const _HeaderCell({required this.column, this.sort, this.onSort});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final active = sort != null && sort!.key == column.sortKey;
    final label = Text(
      column.header,
      style: theme.textTheme.titleSmall?.copyWith(color: active ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant),
    );
    if (column.sortKey == null || onSort == null) return label;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onSort!(sort?.toggle(column.sortKey!) ?? SortState(column.sortKey!)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Flexible(child: label),
            Icon(
              active ? (sort!.ascending ? Icons.arrow_drop_up : Icons.arrow_drop_down) : Icons.unfold_more,
              size: 16,
              color: active ? theme.colorScheme.primary : theme.hintColor,
            ),
          ],
        ),
      ),
    );
  }
}

/// Pagination footer used under tables.
class TablePager extends StatelessWidget {
  final int page;
  final int pageSize;
  final int total;
  final ValueChanged<int> onPage;
  final String Function(int page, int pages) label;

  const TablePager({super.key, required this.page, required this.pageSize, required this.total, required this.onPage, required this.label});

  @override
  Widget build(BuildContext context) {
    final pages = (total / pageSize).ceil().clamp(1, 1 << 30);
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: theme.dividerColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 8,
        children: [
          Text(label(page, pages), style: theme.textTheme.bodySmall),
          IconButton(icon: const Icon(Icons.chevron_left), onPressed: page > 1 ? () => onPage(page - 1) : null),
          IconButton(icon: const Icon(Icons.chevron_right), onPressed: page < pages ? () => onPage(page + 1) : null),
        ],
      ),
    );
  }
}
