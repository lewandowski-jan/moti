import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moti/features/activities/data/models/activity.dart';
import 'package:moti/features/activities/data/models/amount.dart';
import 'package:moti/features/activities/domain/activities_repository.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit(this._activitiesRepository) : super(const ActivitiesState());

  final ActivitiesRepository _activitiesRepository;

  Future<void> fetchActivitiesData() async {
    try {
      emit(state.copyWith(status: ActivitiesStatus.loading));

      final activities = _activitiesRepository.getAllActivities();
      final activityDates = activities
          .where((e) => e.$2.name == 'Pushups')
          .map((e) => e.$2.date)
          .whereNotNull()
          .map((e) => DateTime(e.year, e.month, e.day))
          .toList();
      final now = DateTime.now();
      final doneToday = activityDates.contains(
        DateTime(now.year, now.month, now.day),
      );

      final streak = calculateCurrentStreak(activityDates);
      final maxStreak = calculateLongestStreak(activityDates);

      final totalReps = activities
          .where((e) => e.$2.name == 'Pushups')
          .map((e) => e.$2.amount!.value)
          .fold(
            0,
            (previousValue, element) => previousValue + element!.toInt(),
          );
      final totalToday = activities
          .where((e) => e.$2.name == 'Pushups')
          .where((e) {
            final date = e.$2.date;
            return date != null &&
                date.year == now.year &&
                date.month == now.month &&
                date.day == now.day;
          })
          .map((e) => e.$2.amount!.value)
          .fold(
            0,
            (previousValue, element) => previousValue + element!.toInt(),
          );

      emit(
        state.copyWith(
          status: ActivitiesStatus.success,
          streak: streak,
          maxStreak: maxStreak,
          totalReps: totalReps,
          totalToday: totalToday,
          doneToday: doneToday,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ActivitiesStatus.error));
    }
  }

  int calculateCurrentStreak(List<DateTime> dates) {
    if (dates.isEmpty) {
      return 0;
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final firstDateDifference = today.difference(dates.first).inDays;
    if (firstDateDifference > 1) {
      return 0;
    }

    var streak = 0;
    for (var i = 0; i < dates.length; i++) {
      streak++;

      final date = dates[i];
      final nextDate = i + 1 < dates.length ? dates[i + 1] : null;

      if (nextDate != null) {
        final difference = date.difference(nextDate).inDays;

        if (difference != 1) {
          break;
        }
      }
    }

    return streak;
  }

  int calculateLongestStreak(List<DateTime> dates) {
    var longestStreak = 0;
    var currentStreak = 0;

    if (dates.isEmpty) {
      return 0;
    }

    for (var i = 0; i < dates.length; i++) {
      currentStreak++;

      final date = dates[i];
      final nextDate = i + 1 < dates.length ? dates[i + 1] : null;

      if (nextDate != null) {
        final difference = date.difference(nextDate).inDays;

        if (difference != 1) {
          longestStreak = max(longestStreak, currentStreak);
          currentStreak = 0;
        }
      }
    }

    if (currentStreak > longestStreak) {
      return currentStreak;
    }

    return longestStreak;
  }

  Future<bool> logPushups(int amount) async {
    final activity = Activity(
      name: 'Pushups',
      date: DateTime.now(),
      amount: Amount(
        type: AmountType.reps,
        value: amount.toDouble(),
        unit: AmountUnit.reps,
      ),
    );

    return _logActivity(activity);
  }

  Future<bool> _logActivity(Activity activity) async {
    try {
      await _activitiesRepository.addActivity(activity);
      await fetchActivitiesData();
      return true;
    } catch (e) {
      return false;
    }
  }
}

enum ActivitiesStatus { initial, loading, success, error }

class ActivitiesState extends Equatable {
  const ActivitiesState({
    this.status = ActivitiesStatus.initial,
    this.streak = 0,
    this.maxStreak = 0,
    this.totalReps = 0,
    this.totalToday = 0,
    this.doneToday = false,
  });

  final ActivitiesStatus status;
  final int streak;
  final int maxStreak;
  final int totalReps;
  final int totalToday;
  final bool doneToday;

  ActivitiesState copyWith({
    ActivitiesStatus? status,
    int? streak,
    int? maxStreak,
    int? totalReps,
    int? totalToday,
    bool? doneToday,
  }) {
    return ActivitiesState(
      status: status ?? this.status,
      streak: streak ?? this.streak,
      maxStreak: maxStreak ?? this.maxStreak,
      totalReps: totalReps ?? this.totalReps,
      totalToday: totalToday ?? this.totalToday,
      doneToday: doneToday ?? this.doneToday,
    );
  }

  @override
  List<Object?> get props => [
        status,
        streak,
        maxStreak,
        totalReps,
        totalToday,
        doneToday,
      ];
}
