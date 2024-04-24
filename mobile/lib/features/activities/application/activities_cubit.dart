import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moti/features/activities/domain/activities_repository.dart';
import 'package:moti/features/activities/domain/activity_entity.dart';
import 'package:moti/features/activities/domain/activity_type_value_object.dart';
import 'package:moti/features/common/domain/date_value_object.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit(this._activitiesRepository) : super(const ActivitiesState());

  final ActivitiesRepository _activitiesRepository;

  Future<void> fetchActivitiesData() async {
    try {
      emit(state.copyWith(status: ActivitiesStatus.loading));

      final activities = _activitiesRepository.getAllActivities();

      if (!activities.valid && activities.entities.isNotEmpty) {
        emit(state.copyWith(status: ActivitiesStatus.error));
        return;
      }

      final activityDates = activities.entities
          .where((e) => e.type.type == ActivityType.pushups)
          .map((e) => e.date)
          .where((e) => e.valid)
          .toList();

      final today = DateValueObject.today();
      final doneToday = activityDates.contains(today);

      final streak = activityDates.currentStreak;
      final maxStreak = activityDates.longestStreak;

      final totalReps = activities.totalPushupReps;
      final totalToday = activities.totalPushupRepsToday;

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

  Future<bool> logPushups(int amount) async {
    return _logActivity(ActivityEntity.pushups(amount));
  }

  Future<bool> _logActivity(ActivityEntity activity) async {
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
