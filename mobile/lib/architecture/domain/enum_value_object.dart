import 'package:moti/architecture/domain/value_object_base.dart';

abstract class EnumValueObject<T, R extends Enum> extends ValueObjectBase<R> {
  EnumValueObject(T? value) {
    this.value = validate(value);
  }

  R? validate(T? value);
}
