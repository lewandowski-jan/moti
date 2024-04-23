import 'package:meta/meta.dart';
import 'package:moti/architecture/domain/value_object_base.dart';

class ValueObject<T extends Object> extends ValueObjectBase<T> {
  ValueObject(T? value) {
    this.value = validate(value);
  }

  factory ValueObject.invalid() => ValueObject<T>(null);

  @mustBeOverridden
  T? validate(T? value) {
    if (value == null) {
      return null;
    }

    return value;
  }
}
