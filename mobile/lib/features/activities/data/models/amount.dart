import 'package:collection/collection.dart';

import 'package:moti/core/storable.dart';

enum AmountType { duration, distance, reps, weight }

enum AmountUnit { seconds, meters, reps, kg }

class Amount implements IStorable {
  const Amount({
    required this.type,
    required this.unit,
    required this.value,
  });

  factory Amount.fromJson(Map<dynamic, dynamic> json) {
    return Amount(
      type: json['type'] != null
          ? AmountType.values
              .firstWhereOrNull((e) => e.toString() == json['type'])
          : null,
      unit: json['unit'] != null
          ? AmountUnit.values
              .firstWhereOrNull((e) => e.toString() == json['unit'])
          : null,
      value: json['value'] != null ? json['value'] as double : null,
    );
  }

  final AmountType? type;
  final AmountUnit? unit;
  final double? value;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type?.toString(),
      'unit': unit?.toString(),
      'value': value,
    };
  }

  Amount operator +(Amount other) {
    if (type != other.type || unit != other.unit) {
      throw ArgumentError(
        'Amounts must have the same type and unit to be added.',
      );
    }

    return Amount(
      type: type,
      unit: unit,
      value: value! + other.value!,
    );
  }
}
