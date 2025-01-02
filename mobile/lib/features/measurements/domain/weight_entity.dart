// ignore_for_file: avoid_returning_this

import 'package:moti/architecture/domain/value_object.dart';
import 'package:moti/features/common/domain/timestamp_value_object.dart';
import 'package:moti/features/measurements/data/models/measurement_model.dart';
import 'package:moti/features/measurements/domain/measurement_entity.dart';
import 'package:moti/features/measurements/domain/measurement_unit_value_object.dart';
import 'package:moti/l10n/localizations.dart';

class WeightEntity extends MeasurementEntity {
  factory WeightEntity({
    required double? amount,
    required MeasurementUnit? unit,
  }) {
    return WeightEntity._(
      amount: ValueObject(amount),
      unit: MeasurementUnitValueObject(unit),
      timestamp: TimestampValueObject.now(),
    );
  }

  const WeightEntity._({
    required super.amount,
    required super.unit,
    required super.timestamp,
  });

  WeightEntity.invalid() : super.invalid();

  factory WeightEntity.fromModel(MeasurementModel? model) {
    return WeightEntity._(
      amount: ValueObject(model?.amount),
      unit: MeasurementUnitValueObject(model?.unit),
      timestamp: TimestampValueObject(model?.timestamp),
    );
  }

  String getDisplay(AppLocalizations l10n, MeasurementUnit unit) {
    final amount = this.amount.getOrNull;
    if (amount == null) {
      return '-';
    }

    if (unit == this.unit.get) {
      if (unit == MeasurementUnit.kg) {
        return '$amount ${l10n.weight_unit_kg}';
      }
      if (unit == MeasurementUnit.lb) {
        return '$amount ${l10n.weight_unit_lb}';
      }

      return '';
    }

    if (unit == MeasurementUnit.kg) {
      return inKg.getDisplay(l10n, unit);
    }

    if (unit == MeasurementUnit.lb) {
      return inLb.getDisplay(l10n, unit);
    }

    return '';
  }

  WeightEntity get inKg {
    if (unit.get == MeasurementUnit.kg) {
      return this;
    }

    return WeightEntity._(
      amount: ValueObject(amount.getOr(0) * 0.453592),
      unit: MeasurementUnitValueObject.kg(),
      timestamp: timestamp,
    );
  }

  WeightEntity get inLb {
    if (unit.get == MeasurementUnit.lb) {
      return this;
    }

    return WeightEntity._(
      amount: ValueObject(amount.getOr(0) * 2.20462),
      unit: MeasurementUnitValueObject.lb(),
      timestamp: timestamp,
    );
  }

  @override
  bool get valid =>
      amount.valid &&
      (unit.get == MeasurementUnit.kg || unit.get == MeasurementUnit.lb);
}
