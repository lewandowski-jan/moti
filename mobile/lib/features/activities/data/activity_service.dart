import 'package:moti/core/local_storage.dart';
import 'package:moti/features/activities/data/models/activity_model.dart';

class ActivityService {
  const ActivityService({required LocalStorage storage}) : _storage = storage;

  final LocalStorage _storage;

  Future<void> addActivity(ActivityModel activity) async {
    return _storage.add(activity);
  }

  Map<dynamic, ActivityModel> getAllActivities() {
    return _storage.getAllWithKeys(ActivityModel.fromJson);
  }

  Future<void> updateActivity(int key, ActivityModel model) {
    return _storage.update(key, model);
  }
}
