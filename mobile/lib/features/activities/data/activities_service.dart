import 'package:moti/core/local_storage.dart';
import 'package:moti/features/activities/data/models/activity.dart';

class ActivitiesService {
  const ActivitiesService({required LocalStorage storage}) : _storage = storage;

  final LocalStorage _storage;

  Future<void> addActivity(Activity activity) async {
    return _storage.add(activity);
  }

  Future<void> updateActivity(int key, Activity activity) async {
    return _storage.update(key, activity);
  }

  Map<int, Activity> getAllActivities() {
    return _storage.getAllWithKeys(Activity.fromJson);
  }
}
