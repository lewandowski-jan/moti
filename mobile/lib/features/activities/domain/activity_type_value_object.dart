import 'package:moti/architecture/domain/enum_value_object.dart';

enum ActivityType {
  pushups;

  static const pushupsCode = 'Pushups';
}

class ActivityTypeValueObject extends EnumValueObject<String, ActivityType> {
  ActivityTypeValueObject(super.value);

  factory ActivityTypeValueObject.invalid() => ActivityTypeValueObject(null);

  factory ActivityTypeValueObject.pushups() =>
      ActivityTypeValueObject(ActivityType.pushupsCode);

  ActivityType? get type => value;

  @override
  ActivityType? validate(String? value) {
    return switch (value) {
      ActivityType.pushupsCode ||
      'ActivityType.pushups' =>
        ActivityType.pushups,
      _ => null,
    };
  }
}
