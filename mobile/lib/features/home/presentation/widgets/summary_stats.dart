import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moti/core/context.dart';
import 'package:moti/features/home/presentation/widgets/streak.dart';
import 'package:moti/features/home/presentation/widgets/total.dart';
import 'package:moti/features/profile/application/profile_cubit.dart';

class SummaryStats extends StatelessWidget {
  const SummaryStats({
    super.key,
    required this.totalToday,
    required this.total,
    required this.streak,
    required this.maxStreak,
  });

  final int totalToday;
  final int total;
  final int streak;
  final int maxStreak;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Total(totalToday: totalToday, total: total),
        _TodayCircle(doneToday: totalToday),
        Streak(streak: streak, maxStreak: maxStreak),
      ],
    );
  }
}

class _TodayCircle extends StatelessWidget {
  const _TodayCircle({
    required this.doneToday,
  });

  final int doneToday;

  static const _strokeWidth = 10.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
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
    );
  }
}
