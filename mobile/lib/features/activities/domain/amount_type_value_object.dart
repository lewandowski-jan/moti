import 'package:moti/architecture/domain/enum_value_object.dart';

enum AmountType {
  duration,
  distance,
  reps,
  weight;
}

class AmountTypeValueObject extends TransformValueObject<String, AmountType> {
  AmountTypeValueObject(super.value);

  factory AmountTypeValueObject.invalid() => AmountTypeValueObject(null);

  factory AmountTypeValueObject.from(AmountType type) =>
      AmountTypeValueObject(type.toString());

  @override
  AmountType? validate(String? value) {
    return switch (value) {
      'AmountType.duration' => AmountType.duration,
      'AmountType.distance' => AmountType.distance,
      'AmountType.reps' => AmountType.reps,
      'AmountType.weight' => AmountType.weight,
      _ => null,
    };
  }
}
