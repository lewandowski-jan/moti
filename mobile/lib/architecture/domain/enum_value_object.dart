import 'package:moti/architecture/domain/value_object_base.dart';

abstract class TransformValueObject<T, R extends Object>
    extends ValueObjectBase<R> {
  TransformValueObject(T? value) {
    this.value = validate(value);
  }

  R? validate(T? value);
}
