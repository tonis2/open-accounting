import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_accounting_dashboard/services/format.dart';

void main() {
  test('formatMoney renders cents with grouping and currency symbol', () {
    expect(formatMoney(Int64(123456789), currency: 'EUR'), '€1,234,567.89');
    expect(formatMoney(Int64(-5), currency: 'GBP'), '-£0.05');
    expect(formatMoney(Int64(0)), '0.00');
    expect(formatMoney(Int64(250000), currency: 'EUR', showSign: true), '+€2,500.00');
  });

  test('compact axis labels', () {
    expect(formatMoneyInt(1_500_000, currency: 'EUR', compact: true), '€15k');
    expect(formatMoneyInt(650_000, currency: 'EUR', compact: true), '€6.5k');
    expect(formatMoneyInt(50_000, currency: 'EUR', compact: true), '€500');
    expect(formatMoneyInt(1250, currency: '', compact: true), '12.5');
    expect(formatMoneyInt(20_000_000, currency: 'EUR', compact: true), '€200k');
    expect(formatMoneyInt(150_000_000, currency: 'EUR', compact: true), '€1.5m');
  });

  test('decimal helpers', () {
    expect(trimDecimal('24.00'), '24');
    expect(trimDecimal('2.500'), '2.5');
    expect(trimDecimal('10'), '10');
    expect(parseCents('1 234,50'), 123450);
    expect(parseCents('abc'), isNull);
  });

  test('dates', () {
    expect(formatMonthKey('2026-03'), 'Mar');
    expect(formatMonthKey('2026-03', withYear: true), 'Mar 2026');
    expect(isoDate(DateTime(2026, 9, 3)), '2026-09-03');
    expect(formatIsoDate('2026-09-03'), '03 Sep 26');
    expect(parseIsoDate(''), isNull);
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    expect(daysUntil(isoDate(tomorrow)), 1);
  });
}
