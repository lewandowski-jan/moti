import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:moti/core/context.dart';
import 'package:moti/features/activities/domain/activity_type_value_object.dart';
import 'package:moti/features/home/presentation/widgets/week_chart.dart';
import 'package:moti/features/statistics/application/statistics_cubit.dart';

class StatisticsScreen extends HookWidget {
  const StatisticsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        context.read<StatisticsCubit>().load();
        return;
      },
      [],
    );

    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        if (state.status == StatisticsStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == StatisticsStatus.error) {
          return Center(child: Text(context.l10n.generic_error));
        }

        final activitiesByType = state.lastWeekActivitiesByType;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 64),
              ...activitiesByType.entries.map((entry) {
                final type = ActivityTypeValueObject.fromType(entry.key);
                final activitiesByDate = entry.value.groupListsBy(
                  (e) => e.timestamp.date,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type.getDisplay(context.l10n),
                      style: context.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    WeekChart(
                      lastWeekActivities: activitiesByDate,
                      barColor: context.colors.primary,
                    ),
                    const SizedBox(height: 32),
                  ],
                );
              }),
              const SizedBox(height: 72),
            ],
          ),
        );
      },
    );
  }
}
