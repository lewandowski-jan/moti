import 'package:equatable/equatable.dart';

class ValueObject<T extends Object> extends Equatable {
  ValueObject(T? value) {
    value = validate(value);
  }

  late final T? value;
  T getOr(T fallback) => value ?? fallback;

  bool get valid => value != null;

  T? validate(T? value) {
    if (value == null) {
      return null;
    }

    return value;
  }

  @override
  List<Object?> get props => [value];
}
