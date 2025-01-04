import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:moti/architecture/domain/enum_value_object.dart';

enum ActivityType {
  pushups,
  squats,
  situps,
  invalid;

  static const _mapping = {
    '1': ActivityType.pushups,
    '2': ActivityType.squats,
    '3': ActivityType.situps,
    // legacy values
    'Pushups': ActivityType.pushups,
    'ActivityType.pushups': ActivityType.pushups,
  };

  static ActivityType? fromValue(String value) => _mapping[value];

  String toValue() =>
      _mapping.keys.firstWhereOrNull((key) => _mapping[key] == this) ?? '';
}

class ActivityTypeValueObject
    extends TransformValueObject<String, ActivityType> {
  ActivityTypeValueObject(super.value);

  factory ActivityTypeValueObject.invalid() => ActivityTypeValueObject(null);

  factory ActivityTypeValueObject.pushups() =>
      ActivityTypeValueObject('Pushups');

  ActivityType get get => getOr(ActivityType.invalid);

  @override
  ActivityType? validate(String? value) {
    if (value == null) {
      return null;
    }

    final resolved = ActivityType.fromValue(value);

    if (resolved == null) {
      log('ActivityTypeValueObject.validate: Invalid activity type: $value');
    }

    return resolved;
  }
}
