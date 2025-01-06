import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_comms/flutter_comms.dart';

import 'package:moti/features/activities/application/activities_cubit.dart';
import 'package:moti/features/activities/domain/activities_repository.dart';
import 'package:moti/features/activities/domain/activity_entity.dart';
import 'package:moti/features/activities/domain/activity_type_value_object.dart';
import 'package:moti/features/common/domain/date_value_object.dart';

class StatisticsCubit
    extends ListenerCubit<StatisticsState, ActivitiesMessage> {
  StatisticsCubit({
    required this.activitiesRepository,
  }) : super(StatisticsState.initial());

  final ActivitiesRepository activitiesRepository;

  @override
  void onMessage(ActivitiesMessage message) {
    if (message == ActivitiesMessage.activityLogged) {
      load();
    }
  }

  void load() {
    final activities = activitiesRepository.getAllActivities();

    if (!activities.valid && activities.entities.isNotEmpty) {
      emit(state.copyWith(status: StatisticsStatus.error));
      return;
    }

    final today = DateValueObject.today();
    final weekAgo = today - const Duration(days: 7);
    final lastWeekActivitiesByType = activities.entities
        .where(
          (e) => e.timestamp.date.isAfter(weekAgo),
        )
        .groupListsBy((e) => e.type.get);

    emit(
      state.copyWith(
        status: StatisticsStatus.success,
        lastWeekActivitiesByType: lastWeekActivitiesByType,
      ),
    );
  }
}

enum StatisticsStatus { initial, success, error }

class StatisticsState extends Equatable {
  const StatisticsState({
    required this.status,
    required this.lastWeekActivitiesByType,
  });

  factory StatisticsState.initial() => const StatisticsState(
        status: StatisticsStatus.initial,
        lastWeekActivitiesByType: {},
      );

  final StatisticsStatus status;
  final Map<ActivityType, List<ActivityEntity>> lastWeekActivitiesByType;

  StatisticsState copyWith({
    StatisticsStatus? status,
    Map<ActivityType, List<ActivityEntity>>? lastWeekActivitiesByType,
  }) {
    return StatisticsState(
      status: status ?? this.status,
      lastWeekActivitiesByType:
          lastWeekActivitiesByType ?? this.lastWeekActivitiesByType,
    );
  }

  @override
  List<Object?> get props => [status, lastWeekActivitiesByType];
}
