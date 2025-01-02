import 'package:moti/architecture/domain/entity.dart';
import 'package:moti/architecture/domain/validable.dart';
import 'package:moti/architecture/domain/value_object.dart';
import 'package:moti/features/common/domain/timestamp_value_object.dart';
import 'package:moti/features/measurements/data/models/measurement_model.dart';
import 'package:moti/features/measurements/domain/measurement_unit_value_object.dart';

abstract class MeasurementEntity extends Entity {
  const MeasurementEntity({
    required this.amount,
    required this.unit,
    required this.timestamp,
  });

  MeasurementEntity.invalid()
      : amount = ValueObject.invalid(),
        unit = MeasurementUnitValueObject.invalid(),
        timestamp = TimestampValueObject.invalid();

  final ValueObject<double> amount;
  final MeasurementUnitValueObject unit;
  final TimestampValueObject timestamp;

  MeasurementModel toModel() {
    return MeasurementModel(
      amount: amount.value,
      unit: unit.value,
      timestamp: timestamp.value,
    );
  }

  @override
  List<IValidable> get props => [amount, unit, timestamp];
}
