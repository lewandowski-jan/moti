import 'package:moti/features/measurements/data/weight_service.dart';
import 'package:moti/features/measurements/domain/weight_entity.dart';

class WeightRepository {
  const WeightRepository({required this.weightService});

  final WeightService weightService;

  Future<void> addWeight(WeightEntity weight) async =>
      weightService.addWeight(weight.toModel());

  WeightEntity getLastWeight() {
    final model = weightService.getLastWeight();

    return WeightEntity.fromModel(model);
  }
}
