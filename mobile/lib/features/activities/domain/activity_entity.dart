import 'package:collection/collection.dart';

import 'package:moti/architecture/domain/entity.dart';
import 'package:moti/architecture/domain/validable.dart';
import 'package:moti/features/activities/data/models/activity_model.dart';
import 'package:moti/features/activities/domain/activity_amount_entity.dart';
import 'package:moti/features/activities/domain/activity_type_value_object.dart';
import 'package:moti/features/activities/domain/amount_type_value_object.dart';
import 'package:moti/features/activities/domain/amount_unit_value_object.dart';
import 'package:moti/features/common/domain/double_value_object.dart';
import 'package:moti/features/common/domain/timestamp_value_object.dart';
import 'package:moti/features/measurements/domain/height_entity.dart';
import 'package:moti/features/measurements/domain/weight_entity.dart';
import 'package:moti/features/statistics/domain/moti_points_value_object.dart';

class ActivitiesEntity extends EntityList<ActivityEntity> {
  const ActivitiesEntity(super.entities);

  factory ActivitiesEntity.fromModel(Iterable<ActivityModel> models) {
    return ActivitiesEntity(
      models
          .map(ActivityEntity.fromModel)
          .sorted((l, r) => r.timestamp.compareTo(l.timestamp))
          .toList(),
    );
  }

  List<ActivityModel> toModel() {
    return entities.map((e) => e.toModel()).toList();
  }

  MotiPointsValueObject get totalMotiPoints {
    return entities
        .map((e) => e.motiPoints)
        .where((e) => e.valid)
        .fold(MotiPointsValueObject.fromModel(0), (a, b) => a + b);
  }

  MotiPointsValueObject get totalMotiPointsToday {
    return entities
        .where((e) => e.timestamp.isToday)
        .map((e) => e.motiPoints)
        .where((e) => e.valid)
        .fold(MotiPointsValueObject.fromModel(0), (a, b) => a + b);
  }
}

class ActivityEntity extends Entity {
  const ActivityEntity._({
    required this.type,
    required this.timestamp,
    required this.amount,
    required this.motiPoints,
  });

  factory ActivityEntity.fromModel(ActivityModel? model) {
    return ActivityEntity._(
      type: ActivityTypeValueObject(model?.name),
      timestamp: TimestampValueObject(model?.date),
      amount: ActivityAmountEntity.fromModel(model?.amount),
      motiPoints: MotiPointsValueObject.fromModel(model?.motiPoints),
    );
  }

  factory ActivityEntity.invalid() {
    return ActivityEntity._(
      type: ActivityTypeValueObject.invalid(),
      timestamp: TimestampValueObject.invalid(),
      amount: ActivityAmountEntity.invalid(),
      motiPoints: MotiPointsValueObject.invalid(),
    );
  }

  factory ActivityEntity.pushups({
    required int reps,
    required WeightEntity weight,
    required HeightEntity height,
  }) {
    final type = ActivityTypeValueObject.pushups();
    final amountEntity = ActivityAmountEntity(
      amount: DoubleValueObject(reps.toDouble()),
      type: AmountTypeValueObject.from(AmountType.reps),
      unit: AmountUnitValueObject.from(AmountUnit.reps),
    );

    final motiPoints = MotiPointsValueObject(
      weight: weight,
      height: height,
      activityType: type,
      amount: amountEntity.amount,
      amountType: amountEntity.type,
      amountUnit: amountEntity.unit,
    );

    return ActivityEntity._(
      type: type,
      timestamp: TimestampValueObject.now(),
      amount: amountEntity,
      motiPoints: motiPoints,
    );
  }

  ActivityModel toModel() {
    return ActivityModel(
      name: type.get.toValue(),
      date: timestamp.getOrNull,
      amount: amount.toModel(),
      motiPoints: motiPoints.getOrNull,
    );
  }

  final ActivityTypeValueObject type;
  final TimestampValueObject timestamp;
  final ActivityAmountEntity amount;
  final MotiPointsValueObject motiPoints;

  @override
  bool get valid => type.valid && timestamp.valid && amount.valid;

  @override
  List<IValidable> get props => [type, timestamp, amount, motiPoints];

  ActivityEntity copyWith({
    ActivityTypeValueObject? type,
    TimestampValueObject? timestamp,
    ActivityAmountEntity? amount,
    MotiPointsValueObject? motiPoints,
  }) {
    return ActivityEntity._(
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      amount: amount ?? this.amount,
      motiPoints: motiPoints ?? this.motiPoints,
    );
  }
}
