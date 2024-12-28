import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_comms/flutter_comms.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:moti/features/activities/application/activities_cubit.dart';
import 'package:moti/features/activities/presentation/add_activity.dart';
import 'package:moti/features/activities/presentation/streak.dart';
import 'package:moti/features/activities/presentation/total.dart';
import 'package:moti/features/reminders/local_notifications.dart';
import 'package:moti/features/reminders/presentation/motivational_text_generator.dart';
import 'package:moti/l10n/l10n.dart';

class AcitivityScreen extends HookWidget {
  const AcitivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        context.read<LocalNotifications>().requestPermission();
        context.read<ActivitiesCubit>().fetchActivitiesData();
        return null;
      },
      [],
    );

    useMessageListener<ActivitiesMessage>(
      (message) {
        if (message == ActivitiesMessage.firstActivityLoggedToday) {
          context.read<LocalNotifications>().rescheduleNotifications(
                context.l10n.reminders_reminder_title,
                () => MotivationalTextGenerator.generate(context),
              );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.app_name),
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
              return Center(child: Text(context.l10n.generic_error));
            }
    
            final streak = state.streak;
            final maxStreak = state.maxStreak;
            final doneToday = state.doneToday;
            final totalToday = state.totalToday;
            final total = state.totalReps;
    
            return Column(
              children: [
                if (doneToday)
                  Text(
                    context.l10n.activity_screen_pushups_done,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  )
                else
                  Text(
                    context.l10n.activity_screen_pushups_not_done,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
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
    );
  }
}
