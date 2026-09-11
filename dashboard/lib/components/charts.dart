import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../services/format.dart';
import '../theme.dart';

/// One x-axis bucket (a month) with one or more stacked/grouped values in cents.
class ChartBucket {
  final String label;
  final List<int> values;
  const ChartBucket(this.label, this.values);
}

class ChartSeries {
  final String name;
  final Color color;
  const ChartSeries(this.name, this.color);
}

String _axisLabel(double v, String currency) {
  final cents = v.round();
  if (cents == 0) return '${currencySymbol(currency)}0';
  return formatMoneyInt(cents, currency: currency, compact: true);
}

double _niceInterval(double maxValue) {
  if (maxValue <= 0) return 1000;
  final raw = maxValue / 4;
  final magnitude = math.pow(10, (math.log(raw) / math.ln10).floor()).toDouble();
  for (final step in [1, 2, 2.5, 5, 10]) {
    final candidate = magnitude * step;
    if (candidate >= raw) return candidate;
  }
  return magnitude * 10;
}

Widget _legend(BuildContext context, List<ChartSeries> series) {
  final theme = Theme.of(context);
  return Wrap(
    spacing: 16,
    children: [
      for (final s in series)
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: s.color, borderRadius: BorderRadius.circular(2)),
            ),
            Text(s.name, style: theme.textTheme.bodySmall),
          ],
        ),
    ],
  );
}

/// Grouped bar chart (one bar per series per bucket) or stacked when [stacked].
class BarChartPanel extends StatelessWidget {
  final List<ChartBucket> buckets;
  final List<ChartSeries> series;
  final String currency;
  final bool stacked;
  final double height;

  const BarChartPanel({super.key, required this.buckets, required this.series, required this.currency, this.stacked = false, this.height = 240});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var maxV = 0.0;
    for (final b in buckets) {
      final v = stacked ? b.values.fold<int>(0, (a, c) => a + c) : b.values.fold<int>(0, math.max);
      maxV = math.max(maxV, v.toDouble());
    }
    final interval = _niceInterval(maxV);
    final maxY = maxV == 0 ? interval * 4 : (maxV / interval).ceil() * interval;
    final barWidth = buckets.length > 8 ? 12.0 : 18.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        Align(alignment: Alignment.centerRight, child: _legend(context, series)),
        SizedBox(
          height: height,
          child: BarChart(
            BarChartData(
              maxY: maxY,
              minY: 0,
              alignment: BarChartAlignment.spaceAround,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: interval,
                getDrawingHorizontalLine: (_) => FlLine(color: theme.colorScheme.outlineVariant, strokeWidth: 1),
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 56,
                    interval: interval,
                    getTitlesWidget: (v, meta) => Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Text(_axisLabel(v, currency), style: theme.textTheme.bodySmall, textAlign: TextAlign.right, maxLines: 1, softWrap: false),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: (v, meta) {
                      final i = v.toInt();
                      if (i < 0 || i >= buckets.length) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(buckets[i].label, style: theme.textTheme.bodySmall),
                      );
                    },
                  ),
                ),
              ),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (_) => theme.colorScheme.onSurface,
                  getTooltipItem: (group, gi, rod, ri) {
                    final name = stacked ? series[ri.clamp(0, series.length - 1)].name : series[ri].name;
                    return BarTooltipItem('$name\n${formatMoneyInt(rod.toY.round(), currency: currency)}', const TextStyle(color: Colors.white, fontSize: 12));
                  },
                ),
              ),
              barGroups: [
                for (var i = 0; i < buckets.length; i++)
                  BarChartGroupData(
                    x: i,
                    barsSpace: 4,
                    barRods: stacked
                        ? [_stackedRod(buckets[i], barWidth)]
                        : [
                            for (var s = 0; s < series.length; s++)
                              BarChartRodData(
                                toY: buckets[i].values[s].toDouble(),
                                color: series[s].color,
                                width: barWidth,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
                              ),
                          ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BarChartRodData _stackedRod(ChartBucket b, double width) {
    var from = 0.0;
    final items = <BarChartRodStackItem>[];
    for (var s = 0; s < series.length; s++) {
      final to = from + b.values[s];
      items.add(BarChartRodStackItem(from, to, series[s].color));
      from = to;
    }
    return BarChartRodData(
      toY: from,
      width: width,
      rodStackItems: items,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
      color: Colors.transparent,
    );
  }
}

/// Balance-over-time line with a soft fill, like the Banking panel.
class LineChartPanel extends StatelessWidget {
  final List<String> labels;
  final List<int> values;
  final String currency;
  final double height;

  const LineChartPanel({super.key, required this.labels, required this.values, required this.currency, this.height = 200});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (values.isEmpty) return SizedBox(height: height);
    final maxV = values.fold<int>(0, math.max).toDouble();
    final minV = values.fold<int>(0, math.min).toDouble();
    final interval = _niceInterval(math.max(maxV.abs(), minV.abs()));
    final maxY = maxV <= 0 ? interval : (maxV / interval).ceil() * interval;
    final minY = minV >= 0 ? 0.0 : (minV / interval).floor() * interval;
    final labelStep = (labels.length / 6).ceil().clamp(1, 12);

    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          minY: minY,
          maxY: maxY,
          minX: 0,
          maxX: (values.length - 1).toDouble(),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: interval,
            getDrawingHorizontalLine: (_) => FlLine(color: theme.colorScheme.outlineVariant, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 56,
                interval: interval,
                getTitlesWidget: (v, meta) => Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Text(_axisLabel(v, currency), style: theme.textTheme.bodySmall, textAlign: TextAlign.right, maxLines: 1, softWrap: false),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: 1,
                getTitlesWidget: (v, meta) {
                  final i = v.round();
                  if (i < 0 || i >= labels.length || i % labelStep != 0 || (v - i).abs() > 0.01) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(labels[i], style: theme.textTheme.bodySmall),
                  );
                },
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => theme.colorScheme.onSurface,
              getTooltipItems: (spots) => [
                for (final s in spots)
                  LineTooltipItem(
                    '${labels[s.x.round()]}\n${formatMoneyInt(s.y.round(), currency: currency)}',
                    const TextStyle(color: Colors.white, fontSize: 12),
                  ),
              ],
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [for (var i = 0; i < values.length; i++) FlSpot(i.toDouble(), values[i].toDouble())],
              isCurved: false,
              color: AppColors.chartLine,
              barWidth: 2.5,
              dotData: FlDotData(show: true, getDotPainter: (_, _, _, _) => FlDotCirclePainter(radius: 3, color: AppColors.chartIn, strokeWidth: 0)),
              belowBarData: BarAreaData(show: true, color: AppColors.chartLineFill.withValues(alpha: 0.7)),
            ),
          ],
        ),
      ),
    );
  }
}
