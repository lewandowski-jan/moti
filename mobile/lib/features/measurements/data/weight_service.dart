import 'package:moti/core/local_storage.dart';
import 'package:moti/features/measurements/data/models/measurement_model.dart';

class WeightService {
  const WeightService({required LocalStorage storage}) : _storage = storage;

  final LocalStorage _storage;

  Future<void> addWeight(MeasurementModel measurement) async {
    return _storage.add(measurement);
  }

  Map<dynamic, MeasurementModel> getAllWeights() {
    return _storage.getAllWithKeys(MeasurementModel.fromJson);
  }

  MeasurementModel? getLastWeight() {
    return _storage.getLast(MeasurementModel.fromJson);
  }
}
