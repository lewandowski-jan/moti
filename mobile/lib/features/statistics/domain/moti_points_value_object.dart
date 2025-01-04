import 'package:moti/architecture/domain/value_object.dart';
import 'package:moti/features/activities/domain/activity_type_value_object.dart';
import 'package:moti/features/activities/domain/amount_type_value_object.dart';
import 'package:moti/features/activities/domain/amount_unit_value_object.dart';
import 'package:moti/features/common/domain/double_value_object.dart';
import 'package:moti/features/measurements/domain/height_entity.dart';
import 'package:moti/features/measurements/domain/weight_entity.dart';

extension ActivityTypeX on ActivityTypeValueObject {
  double get weightFraction {
    return switch (get) {
      ActivityType.pushups => 0.6,
      ActivityType.situps => 0.3,
      ActivityType.squats => 0.7,
      ActivityType.invalid => 0,
    };
  }

  double get heightFraction {
    return switch (get) {
      ActivityType.pushups => 0.4,
      ActivityType.situps => 0.3,
      ActivityType.squats => 0.4,
      ActivityType.invalid => 0,
    };
  }
}

class MotiPointsValueObject extends ValueObject<double> {
  factory MotiPointsValueObject({
    required WeightEntity weight,
    required HeightEntity height,
    required DoubleValueObject amount,
    required ActivityTypeValueObject activityType,
    required AmountTypeValueObject amountType,
    required AmountUnitValueObject amountUnit,
  }) {
    if (amountType.getOrNull == AmountType.reps &&
        amountUnit.getOrNull == AmountUnit.reps) {
      final kcal = _calculateRepsKcal(
        weight: weight,
        height: height,
        amount: amount,
        weightFraction: activityType.weightFraction,
        heightFraction: activityType.heightFraction,
      );

      final rounded = double.tryParse(kcal?.toStringAsFixed(1) ?? '');

      return MotiPointsValueObject._(rounded);
    }

    return MotiPointsValueObject.invalid();
  }

  factory MotiPointsValueObject.fromModel(double? value) {
    return MotiPointsValueObject._(value);
  }

  MotiPointsValueObject._(super.value);

  MotiPointsValueObject.invalid() : super.invalid();

  static const _gravity = 9.81;
  static const _joulesPerKcal = 4184.0;
  static const _efficiencyFactor =
      5.0; // accounts for ~20% mechanical efficiency

  static double? _calculateRepsKcal({
    required WeightEntity weight,
    required HeightEntity height,
    required DoubleValueObject amount,
    required double weightFraction,
    required double heightFraction,
  }) {
    final weightKg = weight.inKg.amount.getOrNull;
    final heightCm = height.inCm.amount.getOrNull;
    final reps = amount.getOrNull;
    if (weightKg == null || heightCm == null || reps == null) {
      return null;
    }

    final mechanicalWorkJoules = weightFraction *
        weightKg *
        _gravity *
        heightFraction *
        (heightCm / 100) *
        reps *
        _efficiencyFactor;

    return mechanicalWorkJoules / _joulesPerKcal;
  }

  @override
  double? validate(double? value) {
    if (value == null || value < 0) {
      return null;
    }

    return value;
  }

  MotiPointsValueObject operator +(MotiPointsValueObject other) {
    final value = getOrNull;
    final otherValue = other.getOrNull;
    if (value != null && otherValue != null) {
      return MotiPointsValueObject._(value + otherValue);
    }

    if (value != null) {
      return this;
    }

    if (otherValue != null) {
      return other;
    }

    return MotiPointsValueObject.invalid();
  }
}
