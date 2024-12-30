import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_comms/flutter_comms.dart';
import 'package:moti/features/activities/domain/activities_repository.dart';
import 'package:moti/features/activities/domain/activity_entity.dart';
import 'package:moti/features/activities/domain/activity_type_value_object.dart';
import 'package:moti/features/common/domain/date_value_object.dart';

enum ActivitiesMessage { firstActivityLoggedToday }

class ActivitiesCubit extends Cubit<ActivitiesState>
    with Sender<ActivitiesMessage> {
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
          .where((e) => e.type.get == ActivityType.pushups)
          .map((e) => e.timestamp.date)
          .where((e) => e.valid)
          .toList();

      final today = DateValueObject.today();
      final doneToday = activityDates.contains(today);

      final weekAgo = today - const Duration(days: 7);
      final lastWeekActivities = activities.entities
          .where(
            (e) => e.timestamp.date.isAfter(weekAgo),
          )
          .groupListsBy((e) => e.timestamp.date);

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
          lastWeekActivities: lastWeekActivities,
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

      if (!state.doneToday) {
        send(ActivitiesMessage.firstActivityLoggedToday);
      }

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
    this.lastWeekActivities = const {},
  });

  final ActivitiesStatus status;
  final int streak;
  final int maxStreak;
  final int totalReps;
  final int totalToday;
  final bool doneToday;
  final Map<DateValueObject, List<ActivityEntity>> lastWeekActivities;

  ActivitiesState copyWith({
    ActivitiesStatus? status,
    int? streak,
    int? maxStreak,
    int? totalReps,
    int? totalToday,
    bool? doneToday,
    Map<DateValueObject, List<ActivityEntity>>? lastWeekActivities,
  }) {
    return ActivitiesState(
      status: status ?? this.status,
      streak: streak ?? this.streak,
      maxStreak: maxStreak ?? this.maxStreak,
      totalReps: totalReps ?? this.totalReps,
      totalToday: totalToday ?? this.totalToday,
      doneToday: doneToday ?? this.doneToday,
      lastWeekActivities: lastWeekActivities ?? this.lastWeekActivities,
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
        lastWeekActivities,
      ];
}
