import 'package:flutter/material.dart';
import 'package:moti/core/context.dart';
import 'package:moti/features/home/presentation/widgets/daily_goal.dart';
import 'package:moti/features/home/presentation/widgets/streak.dart';
import 'package:moti/features/home/presentation/widgets/total.dart';
import 'package:moti/features/statistics/domain/moti_points_value_object.dart';

class SummaryStats extends StatelessWidget {
  const SummaryStats({
    super.key,
    required this.totalToday,
    required this.total,
    required this.streak,
    required this.maxStreak,
  });

  final MotiPointsValueObject totalToday;
  final MotiPointsValueObject total;
  final int streak;
  final int maxStreak;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: context.colors.primaryWeak,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Total(
              totalToday: totalToday.getOr(0).round(),
              total: total.getOr(0).round(),
            ),
          ),
          Expanded(
            child: DailyGoal(doneToday: totalToday.getOr(0).round()),
          ),
          Expanded(
            child: Streak(streak: streak, maxStreak: maxStreak),
          ),
        ],
      ),
    );
  }
}
