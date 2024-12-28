// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:moti/architecture/domain/entity.dart';
import 'package:moti/architecture/domain/validable.dart';
import 'package:moti/features/activities/data/models/amount_model.dart';
import 'package:moti/features/activities/domain/amount_type_value_object.dart';
import 'package:moti/features/activities/domain/amount_unit_value_object.dart';
import 'package:moti/features/common/domain/double_value_object.dart';

class ActivityAmountEntity extends Entity {
  const ActivityAmountEntity({
    required this.amount,
    required this.type,
    required this.unit,
  });

  factory ActivityAmountEntity.fromModel(AmountModel? model) {
    return ActivityAmountEntity(
      amount: DoubleValueObject(model?.value),
      type: AmountTypeValueObject(model?.type),
      unit: AmountUnitValueObject(model?.unit),
    );
  }

  factory ActivityAmountEntity.invalid() {
    return ActivityAmountEntity(
      amount: DoubleValueObject.invalid(),
      type: AmountTypeValueObject.invalid(),
      unit: AmountUnitValueObject.invalid(),
    );
  }

  AmountModel toModel() {
    return AmountModel(
      type: type.value.toString(),
      unit: unit.value.toString(),
      value: amount.value,
    );
  }

  final DoubleValueObject amount;
  final AmountTypeValueObject type;
  final AmountUnitValueObject unit;

  ActivityAmountEntity copyWith({
    DoubleValueObject? amount,
    AmountTypeValueObject? type,
    AmountUnitValueObject? unit,
  }) {
    return ActivityAmountEntity(
      amount: amount ?? this.amount,
      type: type ?? this.type,
      unit: unit ?? this.unit,
    );
  }

  ActivityAmountEntity operator +(ActivityAmountEntity other) {
    if (type != other.type || unit != other.unit) {
      throw ArgumentError(
        'Amounts must have the same type and unit to be added.',
      );
    }

    return copyWith(amount: amount + other.amount);
  }

  @override
  List<IValidable> get props => [amount, type, unit];
}
