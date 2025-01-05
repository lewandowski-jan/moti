// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:moti/features/activities/data/activity_service.dart';
import 'package:moti/features/activities/domain/activity_entity.dart';

class ActivitiesRepository {
  final ActivityService _service;

  ActivitiesRepository({
    required ActivityService activityService,
  }) : _service = activityService;

  Future<void> addActivity(ActivityEntity activity) async {
    if (!activity.valid) {
      return;
    }

    final activityType = activity.type;
    if (!activityType.valid) {
      return;
    }

    return _service.addActivity(activity.toModel());
  }

  ActivitiesEntity getAllActivities() {
    final activities = _service.getAllActivities();

    return ActivitiesEntity.fromModel(activities.values);
  }

  Map<int, ActivityEntity> getAllActivitiesMap() {
    final activities = _service.getAllActivities();

    return activities.map(
      (key, model) => MapEntry(key, ActivityEntity.fromModel(model)),
    );
  }

  Future<void> updateActivity({
    required int key,
    required ActivityEntity activity,
  }) {
    return _service.updateActivity(key, activity.toModel());
  }
}
