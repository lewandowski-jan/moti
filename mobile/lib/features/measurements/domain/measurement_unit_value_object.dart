import 'package:moti/architecture/domain/value_object.dart';

enum MeasurementUnit {
  kg,
  lb,
  cm,
  inch,
  invalid;

  @override
  String toString() {
    return super.toString().replaceFirst('MeasurementUnit.', '');
  }

  static MeasurementUnit? fromString(String value) =>
      switch (value.toLowerCase()) {
        'kg' => MeasurementUnit.kg,
        'lb' => MeasurementUnit.lb,
        'cm' => MeasurementUnit.cm,
        'inch' => MeasurementUnit.inch,
        _ => MeasurementUnit.invalid,
      };
}

class MeasurementUnitValueObject extends ValueObject<MeasurementUnit> {
  MeasurementUnitValueObject(super.value);

  MeasurementUnitValueObject.kg() : this(MeasurementUnit.kg);
  MeasurementUnitValueObject.lb() : this(MeasurementUnit.lb);
  MeasurementUnitValueObject.cm() : this(MeasurementUnit.cm);
  MeasurementUnitValueObject.inch() : this(MeasurementUnit.inch);

  MeasurementUnitValueObject.invalid() : super.invalid();

  MeasurementUnit get get => getOr(MeasurementUnit.invalid);

  @override
  MeasurementUnit? validate(MeasurementUnit? value) {
    if (value == MeasurementUnit.invalid) {
      return null;
    }

    return super.validate(value);
  }
}
