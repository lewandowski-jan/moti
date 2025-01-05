import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_comms/flutter_comms.dart';
import 'package:moti/features/activities/domain/activities_repository.dart';
import 'package:moti/features/activities/domain/activity_entity.dart';
import 'package:moti/features/activities/domain/activity_type_value_object.dart';
import 'package:moti/features/common/domain/date_value_object.dart';
import 'package:moti/features/measurements/domain/weight_repository.dart';
import 'package:moti/features/profile/domain/profile_repository.dart';
import 'package:moti/features/statistics/domain/moti_points_value_object.dart';

enum ActivitiesMessage { firstActivityLoggedToday }

class ActivitiesCubit extends Cubit<ActivitiesState>
    with Sender<ActivitiesMessage> {
  ActivitiesCubit({
    required this.activitiesRepository,
    required this.weightRepository,
    required this.profileRepository,
  }) : super(ActivitiesState.initial());

  final ActivitiesRepository activitiesRepository;
  final WeightRepository weightRepository;
  final ProfileRepository profileRepository;

  Future<void> fetchActivitiesData() async {
    try {
      emit(state.copyWith(status: ActivitiesStatus.loading));

      final activities = activitiesRepository.getAllActivities();

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

      final totalMotiPoints = activities.totalMotiPoints;
      final totalMotiPointsToday = activities.totalMotiPointsToday;

      emit(
        state.copyWith(
          status: ActivitiesStatus.success,
          streak: streak,
          maxStreak: maxStreak,
          totalMotiPoints: totalMotiPoints,
          totalMotiPointsToday: totalMotiPointsToday,
          doneToday: doneToday,
          lastWeekActivities: lastWeekActivities,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ActivitiesStatus.error));
    }
  }

  Future<bool> logPushups({
    required int reps,
  }) async {
    final weight = weightRepository.getLastWeight();
    final height = profileRepository.getProfile().height;

    return _logActivity(
      ActivityEntity.pushups(
        reps: reps,
        weight: weight,
        height: height,
      ),
    );
  }

  Future<bool> _logActivity(ActivityEntity activity) async {
    try {
      await activitiesRepository.addActivity(activity);

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
    required this.status,
    required this.streak,
    required this.maxStreak,
    required this.totalMotiPoints,
    required this.totalMotiPointsToday,
    required this.doneToday,
    required this.lastWeekActivities,
  });

  factory ActivitiesState.initial() {
    return ActivitiesState(
      status: ActivitiesStatus.initial,
      streak: 0,
      maxStreak: 0,
      totalMotiPoints: MotiPointsValueObject.invalid(),
      totalMotiPointsToday: MotiPointsValueObject.invalid(),
      doneToday: false,
      lastWeekActivities: const {},
    );
  }

  final ActivitiesStatus status;
  final int streak;
  final int maxStreak;
  final MotiPointsValueObject totalMotiPoints;
  final MotiPointsValueObject totalMotiPointsToday;
  final bool doneToday;
  final Map<DateValueObject, List<ActivityEntity>> lastWeekActivities;

  ActivitiesState copyWith({
    ActivitiesStatus? status,
    int? streak,
    int? maxStreak,
    MotiPointsValueObject? totalMotiPoints,
    MotiPointsValueObject? totalMotiPointsToday,
    bool? doneToday,
    Map<DateValueObject, List<ActivityEntity>>? lastWeekActivities,
  }) {
    return ActivitiesState(
      status: status ?? this.status,
      streak: streak ?? this.streak,
      maxStreak: maxStreak ?? this.maxStreak,
      totalMotiPoints: totalMotiPoints ?? this.totalMotiPoints,
      totalMotiPointsToday: totalMotiPointsToday ?? this.totalMotiPointsToday,
      doneToday: doneToday ?? this.doneToday,
      lastWeekActivities: lastWeekActivities ?? this.lastWeekActivities,
    );
  }

  @override
  List<Object?> get props => [
        status,
        streak,
        maxStreak,
        totalMotiPoints,
        totalMotiPointsToday,
        doneToday,
        lastWeekActivities,
      ];
}
