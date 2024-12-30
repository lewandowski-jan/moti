import 'package:meta/meta.dart';
import 'package:moti/architecture/domain/value_object_base.dart';

class ValueObject<T extends Object> extends ValueObjectBase<T> {
  ValueObject(T? value) {
    this.value = validate(value);
  }

  ValueObject.invalid() : this(null);

  @mustBeOverridden
  T? validate(T? value) {
    if (value == null) {
      return null;
    }

    return value;
  }
}
