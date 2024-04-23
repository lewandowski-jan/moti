import 'package:moti/core/value_object.dart';

class DateValueObject extends ValueObject<DateTime> {
  DateValueObject(super.value);

  @override
  DateTime getOr(DateTime fallback) {
    final result = value ?? fallback;
    return DateTime(result.day, result.month, result.year);
  }

  DateTime? get date =>
      value != null ? DateTime(value!.year, value!.month, value!.day) : null;

  @override
  DateTime? validate(DateTime? value) {
    if (value == null) {
      return null;
    }

    return value;
  }
}
