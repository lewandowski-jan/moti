import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moti/core/context.dart';
import 'package:moti/features/profile/application/profile_cubit.dart';

class DailyGoal extends StatelessWidget {
  const DailyGoal({
    super.key,
    required this.doneToday,
  });

  final int doneToday;

  static const _strokeWidth = 10.0;
  static const _size = 100.0;

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
              height: _size + _strokeWidth,
              width: _size + _strokeWidth,
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: context.colors.secondaryWeak,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      shape: const CircleBorder(),
                      color: context.colors.primary,
                    ),
                    width: _size - _strokeWidth,
                    height: _size - _strokeWidth,
                    alignment: Alignment.center,
                    child: Text(
                      doneToday.toString(),
                      style: context.textTheme.headlineMedium!.copyWith(
                        color: context.colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _size,
                    height: _size,
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
