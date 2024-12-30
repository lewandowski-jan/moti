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

  int get totalPushupReps {
    return entities
        .where((e) => e.type == ActivityTypeValueObject.pushups())
        .map((e) => e.amount.amount)
        .where((e) => e.valid)
        .fold(DoubleValueObject(0), (a, b) => a + b)
        .getOr(0)
        .toInt();
  }

  int get totalPushupRepsToday {
    return entities
        .where((e) => e.type == ActivityTypeValueObject.pushups())
        .where((e) => e.timestamp.isToday)
        .map((e) => e.amount.amount)
        .where((e) => e.valid)
        .fold(DoubleValueObject(0), (a, b) => a + b)
        .getOr(0)
        .toInt();
  }
}

class ActivityEntity extends Entity {
  const ActivityEntity._({
    required this.type,
    required this.timestamp,
    required this.amount,
  });

  factory ActivityEntity.fromModel(ActivityModel? model) {
    return ActivityEntity._(
      type: ActivityTypeValueObject(model?.name),
      timestamp: TimestampValueObject(model?.date),
      amount: ActivityAmountEntity.fromModel(model?.amount),
    );
  }

  factory ActivityEntity.invalid() {
    return ActivityEntity._(
      type: ActivityTypeValueObject.invalid(),
      timestamp: TimestampValueObject.invalid(),
      amount: ActivityAmountEntity.invalid(),
    );
  }

  factory ActivityEntity.pushups(int amount) {
    return ActivityEntity._(
      type: ActivityTypeValueObject.pushups(),
      timestamp: TimestampValueObject(DateTime.now()),
      amount: ActivityAmountEntity(
        amount: DoubleValueObject(amount.toDouble()),
        type: AmountTypeValueObject.from(AmountType.reps),
        unit: AmountUnitValueObject.from(AmountUnit.reps),
      ),
    );
  }

  ActivityModel toModel() {
    return ActivityModel(
      name: type.get.toValue(),
      date: timestamp.value,
      amount: amount.toModel(),
    );
  }

  final ActivityTypeValueObject type;
  final TimestampValueObject timestamp;
  final ActivityAmountEntity amount;

  ActivityEntity operator +(ActivityEntity other) {
    if (type != other.type || timestamp != other.timestamp) {
      throw ArgumentError(
        'Activities must have the same type and date to be added.',
      );
    }

    return ActivityEntity._(
      type: type,
      timestamp: timestamp,
      amount: amount + other.amount,
    );
  }

  @override
  List<IValidable> get props => [type, timestamp, amount];
}
