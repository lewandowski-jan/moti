import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moti/core/colors.dart';
import 'package:moti/core/context.dart';
import 'package:moti/features/activities/domain/activity_entity.dart';
import 'package:moti/features/common/domain/date_value_object.dart';

class WeekChart extends StatefulWidget {
  const WeekChart({
    super.key,
    required this.lastWeekActivities,
    required this.barColor,
  });

  final Map<DateValueObject, List<ActivityEntity>> lastWeekActivities;
  final MTColor barColor;

  @override
  State<WeekChart> createState() => _WeekChartState();
}

class _WeekChartState extends State<WeekChart> {
  late List<BarChartGroupData> barGroups;

  void _updateBarGroups(
    Map<DateValueObject, List<ActivityEntity>> lastWeekActivities,
  ) {
    final today = DateValueObject.today();

    if (lastWeekActivities.length < 7) {
      for (var i = 0; i < 7; i++) {
        if (lastWeekActivities.containsKey(today - Duration(days: i))) {
          continue;
        }

        lastWeekActivities[today - Duration(days: i)] = [];
      }
    }

    barGroups = lastWeekActivities.entries
        .sorted((l, r) => l.key.compareTo(r.key))
        .mapIndexed(
          (index, entry) => BarChartGroupData(
            barsSpace: 4,
            x: index,
            barRods: [
              BarChartRodData(
                toY: entry.value.fold(
                  0,
                  (sum, e) => sum + e.amount.amount.getOr(0),
                ),
                color: widget.barColor,
                width: 10,
              ),
            ],
          ),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _updateBarGroups(widget.lastWeekActivities);
  }

  @override
  void didUpdateWidget(WeekChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.lastWeekActivities != oldWidget.lastWeekActivities) {
      _updateBarGroups(widget.lastWeekActivities);
    }
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: widget.barColor,
          width: 10,
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final today = DateValueObject.today();
    final days = List.generate(
      7,
      (index) => today - Duration(days: index),
    ).reversed;
    final titles = days
        .map(
          (date) =>
              DateFormat.E(context.locale.toLanguageTag()).format(date.value!),
        )
        .toList();

    final Widget text = Text(
      titles[value.toInt()],
      style: context.textTheme.labelLarge,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        value.round().toString(),
        style: context.textTheme.labelLarge,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) {
                return context.colors.transparent;
              },
              getTooltipItem: (a, b, c, d) => null,
            ),
          ),
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(),
            topTitles: const AxisTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: bottomTitles,
                reservedSize: 42,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                getTitlesWidget: leftTitles,
                showTitles: true,
                reservedSize: 36,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: barGroups,
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }
}
