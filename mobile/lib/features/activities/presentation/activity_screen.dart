import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moti/features/activities/application/activities_cubit.dart';
import 'package:moti/features/activities/presentation/add_activity.dart';
import 'package:moti/features/activities/presentation/streak.dart';
import 'package:moti/features/activities/presentation/total.dart';

class AcitivityScreen extends StatelessWidget {
  const AcitivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ActivitiesCubit(context.read())..fetchActivitiesData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pushups'),
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<ActivitiesCubit, ActivitiesState>(
            builder: (context, state) {
              if (state.status
                  case ActivitiesStatus.loading || ActivitiesStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == ActivitiesStatus.error) {
                return const Center(child: Text('Something went wrong!'));
              }

              final streak = state.streak;
              final maxStreak = state.maxStreak;
              final doneToday = state.doneToday;
              final totalToday = state.totalToday;
              final total = state.totalReps;

              return Column(
                children: [
                  if (doneToday)
                    const Text(
                      'You have already done pushups today, you will carry the logs!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                    )
                  else
                    const Text(
                      "You have not done pushups today, who's gonna carry the logs?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                    ),
                  const SizedBox(height: 32),
                  Streak(streak: streak, maxStreak: maxStreak),
                  const SizedBox(height: 16),
                  Total(totalToday: totalToday, total: total),
                  const SizedBox(height: 64),
                  AddActivity(
                    onAdd: context.read<ActivitiesCubit>().logPushups,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
