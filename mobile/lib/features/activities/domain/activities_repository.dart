// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:moti/features/activities/data/activity_service.dart';
import 'package:moti/features/activities/domain/activity_entity.dart';

class ActivitiesRepository {
  final ActivityService _service;

  ActivitiesRepository({
    required ActivityService activityService,
  }) : _service = activityService;

  Future<void> addActivity(ActivityEntity activity) async {
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
}
