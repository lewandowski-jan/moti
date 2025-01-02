import 'package:moti/architecture/domain/value_object.dart';

class PositiveIntegerValueObject extends ValueObject<int> {
  PositiveIntegerValueObject(super.value);

  PositiveIntegerValueObject.invalid() : super.invalid();

  @override
  int? validate(int? value) {
    if (value == null || value <= 0) {
      return null;
    }

    return value;
  }
}
