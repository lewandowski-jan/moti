import 'package:moti/architecture/domain/value_object.dart';

class StringNonEmptyValueObject extends ValueObject<String> {
  StringNonEmptyValueObject(super.value);

  StringNonEmptyValueObject.invalid() : super.invalid();

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return value;
  }
}
