import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moti/core/context.dart';
import 'package:moti/features/home/presentation/widgets/streak.dart';
import 'package:moti/features/home/presentation/widgets/total.dart';
import 'package:moti/features/profile/application/profile_cubit.dart';
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
    return Row(
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
    );
  }
}

class DailyGoal extends StatelessWidget {
  const DailyGoal({
    super.key,
    required this.doneToday,
  });

  final int doneToday;

  static const _strokeWidth = 10.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.l10n.profile_daily_goal,
          style: context.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Container(
              height: 100 + _strokeWidth,
              width: 100 + _strokeWidth,
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: context.colors.primaryWeak,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      shape: const CircleBorder(),
                      color: context.colors.primary,
                    ),
                    width: 100 - _strokeWidth,
                    height: 100 - _strokeWidth,
                    alignment: Alignment.center,
                    child: Text(
                      doneToday.toString(),
                      style: context.textTheme.headlineMedium!.copyWith(
                        color: context.colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: doneToday / (state.dailyGoal.getOr(100)),
                      strokeWidth: _strokeWidth,
                      color: context.colors.secondary,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
