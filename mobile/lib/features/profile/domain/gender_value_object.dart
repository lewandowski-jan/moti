import 'package:moti/architecture/domain/value_object.dart';
import 'package:moti/l10n/localizations.dart';

enum Gender {
  male,
  female,
  invalid;

  @override
  String toString() {
    switch (this) {
      case male:
        return 'male';
      case female:
        return 'female';
      case invalid:
        return '';
    }
  }

  static Gender? fromString(String? value) {
    switch (value) {
      case 'male':
        return male;
      case 'female':
        return female;
    }

    return null;
  }
}

class GenderValueObject extends ValueObject<Gender> {
  GenderValueObject(super.value);

  GenderValueObject.invalid() : super.invalid();

  Gender get get => getOr(Gender.invalid);

  String getDisplay(AppLocalizations l10n) {
    return switch (get) {
      Gender.male => l10n.gender_male,
      Gender.female => l10n.gender_female,
      Gender.invalid => '-',
    };
  }

  @override
  Gender? validate(Gender? value) {
    if (value == null) {
      return null;
    }

    return value;
  }
}
