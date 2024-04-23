import 'package:moti/core/local_storage.dart';
import 'package:moti/features/activities/data/models/activity_model.dart';

class ActivitiesService {
  const ActivitiesService({required LocalStorage storage}) : _storage = storage;

  final LocalStorage _storage;

  Future<void> addActivity(ActivityModel activity) async {
    return _storage.add(activity);
  }

  Future<void> updateActivity(int key, ActivityModel activity) async {
    return _storage.update(key, activity);
  }

  Map<int, ActivityModel> getAllActivities() {
    return _storage.getAllWithKeys(ActivityModel.fromJson);
  }
}
