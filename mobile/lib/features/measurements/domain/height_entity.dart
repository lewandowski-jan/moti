// ignore_for_file: avoid_returning_this

import 'package:moti/architecture/domain/value_object.dart';
import 'package:moti/features/common/domain/timestamp_value_object.dart';
import 'package:moti/features/measurements/data/models/measurement_model.dart';
import 'package:moti/features/measurements/domain/measurement_entity.dart';
import 'package:moti/features/measurements/domain/measurement_unit_value_object.dart';
import 'package:moti/l10n/localizations.dart';

class HeightEntity extends MeasurementEntity {
  factory HeightEntity({
    required double? amount,
    required MeasurementUnit? unit,
  }) {
    return HeightEntity._(
      amount: ValueObject(amount),
      unit: MeasurementUnitValueObject(unit),
      timestamp: TimestampValueObject.now(),
    );
  }

  const HeightEntity._({
    required super.amount,
    required super.unit,
    required super.timestamp,
  });

  HeightEntity.invalid() : super.invalid();

  factory HeightEntity.fromModel(MeasurementModel? model) {
    return HeightEntity._(
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
      if (unit == MeasurementUnit.cm) {
        return '$amount ${l10n.height_unit_cm}';
      }
      if (unit == MeasurementUnit.inch) {
        return '$amount ${l10n.height_unit_in}';
      }

      return '';
    }

    if (unit == MeasurementUnit.cm) {
      return inCm.getDisplay(l10n, unit);
    }

    if (unit == MeasurementUnit.inch) {
      return inInches.getDisplay(l10n, unit);
    }

    return '';
  }

  HeightEntity get inCm {
    if (unit.get == MeasurementUnit.cm) {
      return this;
    }

    return HeightEntity._(
      amount: ValueObject(amount.getOr(0) * 2.54),
      unit: MeasurementUnitValueObject.cm(),
      timestamp: timestamp,
    );
  }

  HeightEntity get inInches {
    if (unit.get == MeasurementUnit.inch) {
      return this;
    }

    return HeightEntity._(
      amount: ValueObject(amount.getOr(0) * 0.393701),
      unit: MeasurementUnitValueObject.inch(),
      timestamp: timestamp,
    );
  }

  @override
  bool get valid =>
      amount.valid && unit.get == MeasurementUnit.cm ||
      unit.get == MeasurementUnit.inch;
}
