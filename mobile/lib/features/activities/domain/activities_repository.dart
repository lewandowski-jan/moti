// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:moti/features/activities/data/activities_service.dart';
import 'package:moti/features/activities/domain/activity_entity.dart';
import 'package:moti/features/activities/domain/activity_type_value_object.dart';

class ActivitiesRepository {
  final ActivitiesService _service;

  ActivitiesRepository({
    required ActivitiesService service,
  }) : _service = service;

  Future<void> addActivity(ActivityEntity activity) async {
    final activityType = activity.type;
    if (!activityType.valid) {
      return;
    }

    final activities = _service.getAllActivities();
    final lastActivityEntry = activities.entries.firstWhereOrNull(
      (e) => ActivityEntity.fromModel(e.value).type == activityType,
    );
    if (lastActivityEntry == null) {
      return _service.addActivity(activity.toModel());
    }

    final (key, lastActivity) = (
      lastActivityEntry.key,
      ActivityEntity.fromModel(lastActivityEntry.value),
    );

    final lastDate = lastActivity.date;
    if (!lastDate.valid || !lastDate.isToday) {
      return _service.addActivity(activity.toModel());
    }

    return _service.updateActivity(
      key,
      (lastActivity + activity).toModel(),
    );
  }

  ActivitiesEntity getAllActivities() {
    final activities = _service.getAllActivities();

    return ActivitiesEntity.fromModel(
      activities.entries.map((e) => e.value),
    );
  }

  ActivityEntity getLastActivity(ActivityTypeValueObject type) {
    final activities = _service.getAllActivities();
    final lastActivity = activities.values.firstWhereOrNull(
      (e) => ActivityEntity.fromModel(e).type == type,
    );

    if (lastActivity == null) {
      return ActivityEntity.invalid();
    }

    return ActivityEntity.fromModel(lastActivity);
  }
}
