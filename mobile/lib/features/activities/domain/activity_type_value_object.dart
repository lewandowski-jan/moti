import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:moti/architecture/domain/enum_value_object.dart';
import 'package:moti/l10n/localizations.dart';

enum ActivityType {
  pushups,
  squats,
  situps,
  jumpingJacks,
  burpees,
  invalid;

  static const _mapping = {
    '1': ActivityType.pushups,
    '2': ActivityType.squats,
    '3': ActivityType.situps,
    '4': ActivityType.jumpingJacks,
    '5': ActivityType.burpees,
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

  factory ActivityTypeValueObject.fromType(ActivityType type) {
    return ActivityTypeValueObject(type.toValue());
  }

  factory ActivityTypeValueObject.invalid() => ActivityTypeValueObject(null);

  factory ActivityTypeValueObject.pushups() =>
      ActivityTypeValueObject('Pushups');

  ActivityType get get => getOr(ActivityType.invalid);

  String getDisplay(AppLocalizations l10n) {
    return switch (get) {
      ActivityType.pushups => l10n.activity_pushups,
      ActivityType.squats => l10n.activity_squats,
      ActivityType.situps => l10n.activity_situps,
      ActivityType.jumpingJacks => l10n.activity_jumping_jacks,
      ActivityType.burpees => l10n.activity_burpees,
      ActivityType.invalid => '',
    };
  }

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
