// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:moti/features/activities/data/activities_service.dart';
import 'package:moti/features/activities/data/models/activity.dart';

class ActivitiesRepository {
  final ActivitiesService _service;

  ActivitiesRepository({
    required ActivitiesService service,
  }) : _service = service;

  Future<void> addActivity(Activity activity) async {
    final last = getLastActivity(activity.name!);
    if (last == null) {
      return _service.addActivity(activity);
    }

    final (key, lastActivity) = last;
    final lastDate = lastActivity.date;
    if (lastDate != null) {
      final now = DateTime.now();
      final isSameDay = now.year == lastDate.year &&
          now.month == lastDate.month &&
          now.day == lastDate.day;

      if (isSameDay) {
        return updateActivity(
          key,
          lastActivity.copyWith(
            amount: lastActivity.amount! + activity.amount!,
          ),
        );
      }

      return _service.addActivity(activity);
    }
  }

  List<(int, Activity)> getAllActivities() {
    final now = DateTime.now();
    const year = Duration(days: 365);

    final activities = _service.getAllActivities();

    return activities.entries
        .where((entry) {
          return now.difference(entry.value.date!) < year;
        })
        .sorted((l, r) => r.value.date!.compareTo(l.value.date!))
        .map((e) => (e.key, e.value))
        .toList();
  }

  (int, Activity)? getLastActivity(String name) {
    return getAllActivities().firstWhereOrNull((e) => e.$2.name == name);
  }

  Future<void> updateActivity(int key, Activity activity) {
    return _service.updateActivity(key, activity);
  }
}
