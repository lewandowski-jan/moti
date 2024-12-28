import 'package:moti/architecture/domain/enum_value_object.dart';

enum AmountUnit { seconds, meters, reps, kg }

class AmountUnitValueObject extends TransformValueObject<String, AmountUnit> {
  AmountUnitValueObject(super.value);

  factory AmountUnitValueObject.invalid() => AmountUnitValueObject(null);

  factory AmountUnitValueObject.from(AmountUnit unit) =>
      AmountUnitValueObject(unit.toString());

  @override
  AmountUnit? validate(String? value) {
    return switch (value) {
      'AmountUnit.seconds' => AmountUnit.seconds,
      'AmountUnit.meters' => AmountUnit.meters,
      'AmountUnit.reps' => AmountUnit.reps,
      'AmountUnit.kg' => AmountUnit.kg,
      _ => null,
    };
  }
}
