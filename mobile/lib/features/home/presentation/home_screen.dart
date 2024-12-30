import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_comms/flutter_comms.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:moti/core/context.dart';
import 'package:moti/core/routes.dart';
import 'package:moti/features/activities/application/activities_cubit.dart';
import 'package:moti/features/home/presentation/widgets/add_activity.dart';
import 'package:moti/features/home/presentation/widgets/summary_stats.dart';
import 'package:moti/features/home/presentation/widgets/week_chart.dart';
import 'package:moti/features/reminders/local_notifications.dart';
import 'package:moti/features/reminders/presentation/motivational_text_generator.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

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
                () => MotivationalTextGenerator.generate(context.l10n),
              );
        }
      },
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: context.brightness,
        ),
        backgroundColor: context.colors.transparent,
        forceMaterialTransparency: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton.filled(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(context.colors.primary),
          ),
          color: context.colors.white,
          icon: const Icon(Icons.person),
        ),
        actions: [
          IconButton.filled(
            onPressed: () => SettingsRoute().go(context),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(context.colors.primary),
            ),
            color: context.colors.white,
            icon: const Icon(Icons.settings),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
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
        // final doneToday = state.doneToday;
        final totalToday = state.totalToday;
        final total = state.totalReps;
        final lastWeekActivities = state.lastWeekActivities;

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: kToolbarHeight + 48 + 24),
                  WeekChart(
                    lastWeekActivities: lastWeekActivities,
                    barColor: context.colors.primary,
                  ),
                  const SizedBox(height: 48),
                  SummaryStats(
                    totalToday: totalToday,
                    total: total,
                    streak: streak,
                    maxStreak: maxStreak,
                  ),
                  const SizedBox(height: 40),
                  AddActivity(
                    onAdd: context.read<ActivitiesCubit>().logPushups,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: kToolbarHeight + 48 + 24,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      height: 200,
                      width: 200,
                      color: context.colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
