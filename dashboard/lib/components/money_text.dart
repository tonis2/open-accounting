import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';

import '../services/format.dart';
import '../theme.dart';

/// Right-aligned money value; negatives in red, optional green for positives.
class MoneyText extends StatelessWidget {
  final Int64 cents;
  final String currency;
  final TextStyle? style;
  final bool colorPositive;
  final bool showSign;

  const MoneyText(this.cents, {super.key, this.currency = '', this.style, this.colorPositive = false, this.showSign = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color? color;
    if (cents < Int64.ZERO) color = theme.colorScheme.error;
    if (cents > Int64.ZERO && colorPositive) color = AppColors.success;
    return Text(
      formatMoney(cents, currency: currency, showSign: showSign),
      style: (style ?? theme.textTheme.bodyMedium)?.copyWith(color: color, fontFeatures: const [FontFeature.tabularFigures()]),
      textAlign: TextAlign.right,
    );
  }
}
