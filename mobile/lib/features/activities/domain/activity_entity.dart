import 'package:collection/collection.dart';
import 'package:moti/architecture/domain/entity.dart';
import 'package:moti/architecture/domain/validable.dart';
import 'package:moti/features/activities/data/models/activity_model.dart';
import 'package:moti/features/activities/domain/activity_amount_entity.dart';
import 'package:moti/features/activities/domain/activity_type_value_object.dart';
import 'package:moti/features/activities/domain/amount_type_value_object.dart';
import 'package:moti/features/activities/domain/amount_unit_value_object.dart';
import 'package:moti/features/common/domain/date_value_object.dart';
import 'package:moti/features/common/domain/double_value_object.dart';

class ActivitiesEntity extends EntityList<ActivityEntity> {
  const ActivitiesEntity(super.entities);

  factory ActivitiesEntity.fromModel(Iterable<ActivityModel> models) {
    return ActivitiesEntity(
      models
          .map(ActivityEntity.fromModel)
          .sorted((l, r) => r.date.compareTo(l.date))
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
        .where((e) => e.date.isToday)
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
    required this.date,
    required this.amount,
  });

  factory ActivityEntity.fromModel(ActivityModel? model) {
    return ActivityEntity._(
      type: ActivityTypeValueObject(model?.name),
      date: DateValueObject(model?.date),
      amount: ActivityAmountEntity.fromModel(model?.amount),
    );
  }

  factory ActivityEntity.invalid() {
    return ActivityEntity._(
      type: ActivityTypeValueObject.invalid(),
      date: DateValueObject.invalid(),
      amount: ActivityAmountEntity.invalid(),
    );
  }

  factory ActivityEntity.pushups(int amount) {
    return ActivityEntity._(
      type: ActivityTypeValueObject.pushups(),
      date: DateValueObject(DateTime.now()),
      amount: ActivityAmountEntity(
        amount: DoubleValueObject(amount.toDouble()),
        type: AmountTypeValueObject.from(AmountType.reps),
        unit: AmountUnitValueObject.from(AmountUnit.reps),
      ),
    );
  }

  ActivityModel toModel() {
    return ActivityModel(
      name: type.value.toString(),
      date: date.value,
      amount: amount.toModel(),
    );
  }

  final ActivityTypeValueObject type;
  final DateValueObject date;
  final ActivityAmountEntity amount;

  ActivityEntity operator +(ActivityEntity other) {
    if (type != other.type || date != other.date) {
      throw ArgumentError(
        'Activities must have the same type and date to be added.',
      );
    }

    return ActivityEntity._(
      type: type,
      date: date,
      amount: amount + other.amount,
    );
  }

  @override
  List<IValidable> get props => [type, date, amount];
}
