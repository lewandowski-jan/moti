import 'package:moti/architecture/domain/value_object.dart';

class DoubleValueObject extends ValueObject<double> {
  DoubleValueObject(super.value);

  factory DoubleValueObject.invalid() => DoubleValueObject(null);
  
  @override
  double? validate(double? value) {
    return value;
  }

  DoubleValueObject operator+ (DoubleValueObject other) {
    if (!valid || !other.valid) {
      return DoubleValueObject.invalid();
    }

    return DoubleValueObject(value! + other.value!);
  }
}
