import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_accounting_dashboard/components/index.dart';
import 'package:open_accounting_dashboard/l10n/app_localizations.dart';
import 'package:open_accounting_dashboard/pages/invoices/invoice_status.dart';
import 'package:open_accounting_dashboard/services/format.dart';
import 'package:open_accounting_dashboard/state.dart';
import 'package:open_accounting_dashboard/theme.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: appThemeData,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: Builder(builder: (context) => child)),
);

void main() {
  testWidgets('open invoice shows days until due', (tester) async {
    final inv = Invoice(status: InvoiceStatus.INVOICE_STATUS_OPEN, dueDate: isoDate(DateTime.now().add(const Duration(days: 19))));
    await tester.pumpWidget(_wrap(Builder(builder: (c) => invoiceStatusText(c, inv))));
    expect(find.textContaining('due in 19 days'), findsOneWidget);
  });

  testWidgets('overdue invoice is flagged', (tester) async {
    final inv = Invoice(status: InvoiceStatus.INVOICE_STATUS_OPEN, dueDate: isoDate(DateTime.now().subtract(const Duration(days: 3))), isOverdue: true);
    await tester.pumpWidget(_wrap(Builder(builder: (c) => invoiceStatusBadge(c, inv))));
    expect(find.text('Overdue'), findsOneWidget);
  });

  testWidgets('paid invoice shows paid date', (tester) async {
    final inv = Invoice(status: InvoiceStatus.INVOICE_STATUS_PAID, totalCents: Int64(100));
    await tester.pumpWidget(_wrap(Builder(builder: (c) => invoiceStatusText(c, inv))));
    expect(find.textContaining('Paid'), findsOneWidget);
  });

  testWidgets('CustomTable sorts on header tap', (tester) async {
    SortState? received;
    await tester.pumpWidget(
      _wrap(
        StatefulBuilder(
          builder: (context, setState) => CustomTable(
            columns: const [
              TableColumn(header: 'Name', sortKey: 'name'),
              TableColumn(header: 'Total', sortKey: 'total'),
            ],
            itemCount: 1,
            rowBuilder: (_) => const [Text('a'), Text('1')],
            sort: received,
            onSort: (s) => setState(() => received = s),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Total'));
    await tester.pump();
    expect(received?.key, 'total');
    expect(received?.ascending, isTrue);
    await tester.tap(find.text('Total'));
    await tester.pump();
    expect(received?.ascending, isFalse);
  });
}
