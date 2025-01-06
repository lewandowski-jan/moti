import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_comms/flutter_comms.dart';
import 'package:moti/core/remap.dart';
import 'package:moti/features/activities/application/activities_cubit.dart';
import 'package:moti/features/activities/domain/activities_repository.dart';
import 'package:moti/features/activities/domain/activity_entity.dart';
import 'package:moti/features/common/domain/date_value_object.dart';
import 'package:moti/features/profile/application/profile_cubit.dart';
import 'package:moti/features/profile/domain/profile_repository.dart';

class MotiIndexCubit extends Cubit<int> with MultiListener {
  MotiIndexCubit({
    required this.activitiesRepository,
    required this.profileRepository,
  }) : super(0) {
    listen();
  }

  final ActivitiesRepository activitiesRepository;
  final ProfileRepository profileRepository;

  @override
  List<ListenerDelegate> get listenerDelegates => [
        ListenerDelegate<ProfileMessage>(),
        ListenerDelegate<ActivitiesMessage>(),
      ];

  @override
  void onMessage(dynamic message) {
    if (message == ProfileMessage.profileUpdated ||
        message == ActivitiesMessage.activityLogged) {
      load();
    }
  }

  void load() {
    final dailyGoal = profileRepository.getProfile().dailyGoal.getOr(100);
    final activities = activitiesRepository.getAllActivities();

    final today = DateValueObject.today();
    final weekAgo = today - const Duration(days: DateTime.daysPerWeek);
    final lastWeekMotiPoints = ActivitiesEntity(
      activities.entities
          .where(
            (e) => e.timestamp.date.isAfter(weekAgo),
          )
          .toList(),
    ).totalMotiPoints.getOr(0);
    final dailyAverageMotiPoints = lastWeekMotiPoints / DateTime.daysPerWeek;
    final motiIndex =
        (dailyAverageMotiPoints / dailyGoal).clamp(0, 1).remap(0, 100).round();

    emit(motiIndex);
  }

  @override
  Future<void> close() {
    cancel();

    return super.close();
  }
}
