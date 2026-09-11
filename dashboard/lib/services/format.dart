import 'package:fixnum/fixnum.dart';
import 'package:intl/intl.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

/// Formats integer cents as "1,234.56" with an optional currency symbol prefix.
String formatMoney(Int64 cents, {String currency = '', bool compact = false, bool showSign = false}) {
  return formatMoneyInt(cents.toInt(), currency: currency, compact: compact, showSign: showSign);
}

String formatMoneyInt(int cents, {String currency = '', bool compact = false, bool showSign = false}) {
  final negative = cents < 0;
  final abs = cents.abs();
  String body;
  if (compact) {
    // Axis-style labels: 1,234,500 cents -> "12.3k", 50,000 -> "500", 150,000,000 -> "1.5m"
    final units = abs / 100;
    String short(double v) => trimDecimal(v.toStringAsFixed(1));
    if (units >= 1000000) {
      body = '${short(units / 1000000)}m';
    } else if (units >= 1000) {
      body = '${units >= 100000 ? (units / 1000).round().toString() : short(units / 1000)}k';
    } else {
      body = trimDecimal(units.toStringAsFixed(2));
    }
  } else {
    body = NumberFormat('#,##0.00', 'en_US').format(abs / 100);
  }
  final symbol = currencySymbol(currency);
  final sign = negative ? '-' : (showSign && cents > 0 ? '+' : '');
  return '$sign$symbol$body';
}

String currencySymbol(String code) {
  switch (code.toUpperCase()) {
    case 'EUR':
      return '€';
    case 'GBP':
      return '£';
    case 'USD':
      return '\$';
    case '':
      return '';
    default:
      return '$code ';
  }
}

final _dayMonthYear = DateFormat('dd MMM yy');
final _dayMonthLong = DateFormat('d MMM yyyy');
final _monthShort = DateFormat('MMM');
final _monthYear = DateFormat('MMM yyyy');
final _iso = DateFormat('yyyy-MM-dd');

String formatDate(DateTime d) => _dayMonthYear.format(d);
String formatDateLong(DateTime d) => _dayMonthLong.format(d);
String formatTimestamp(Timestamp ts) => ts.hasSeconds() ? formatDate(ts.toDateTime().toLocal()) : '';
String formatDateTime(Timestamp ts) => ts.hasSeconds() ? DateFormat('dd MMM yy, HH:mm').format(ts.toDateTime().toLocal()) : '';
String isoDate(DateTime d) => _iso.format(d);

/// Parses "YYYY-MM-DD"; returns null when empty or malformed.
DateTime? parseIsoDate(String s) {
  if (s.isEmpty) return null;
  try {
    return DateTime.parse(s);
  } catch (_) {
    return null;
  }
}

String formatIsoDate(String iso) {
  final d = parseIsoDate(iso);
  return d == null ? '' : formatDate(d);
}

/// "2026-03" -> "Mar" (or "Mar 2026" when [withYear]).
String formatMonthKey(String key, {bool withYear = false}) {
  final parts = key.split('-');
  if (parts.length != 2) return key;
  final d = DateTime(int.parse(parts[0]), int.parse(parts[1]));
  return withYear ? _monthYear.format(d) : _monthShort.format(d);
}

String monthKey(DateTime d) => '${d.year}-${d.month.toString().padLeft(2, '0')}';

/// Turns a decimal string like "24.00" into "24" or "2.500" into "2.5".
String trimDecimal(String s) {
  if (!s.contains('.')) return s;
  var out = s.replaceAll(RegExp(r'0+$'), '');
  if (out.endsWith('.')) out = out.substring(0, out.length - 1);
  return out;
}

/// Parses a money string typed by the user ("1 234,50") to cents.
int? parseCents(String input) {
  final cleaned = input.replaceAll(' ', '').replaceAll(',', '.');
  if (cleaned.isEmpty) return null;
  final v = double.tryParse(cleaned);
  if (v == null) return null;
  return (v * 100).round();
}

int daysUntil(String isoDate) {
  final d = parseIsoDate(isoDate);
  if (d == null) return 0;
  final today = DateTime.now();
  return DateTime(d.year, d.month, d.day).difference(DateTime(today.year, today.month, today.day)).inDays;
}
