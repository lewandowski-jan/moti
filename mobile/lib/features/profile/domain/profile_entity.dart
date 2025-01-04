import 'package:moti/architecture/domain/entity.dart';
import 'package:moti/architecture/domain/positive_integer_value_object.dart';
import 'package:moti/architecture/domain/string_non_empty_value_object.dart';
import 'package:moti/architecture/domain/validable.dart';
import 'package:moti/features/measurements/domain/height_entity.dart';
import 'package:moti/features/profile/data/profile_model.dart';
import 'package:moti/features/profile/domain/gender_value_object.dart';

class ProfileEntity extends Entity {
  const ProfileEntity({
    required this.name,
    required this.height,
    required this.gender,
    required this.dailyGoal,
  });

  ProfileEntity.invalid()
      : name = StringNonEmptyValueObject.invalid(),
        height = HeightEntity.invalid(),
        gender = GenderValueObject.invalid(),
        dailyGoal = PositiveIntegerValueObject.invalid();

  factory ProfileEntity.fromModel(ProfileModel? model) {
    if (model == null) {
      return ProfileEntity.invalid();
    }

    return ProfileEntity(
      name: StringNonEmptyValueObject(model.name),
      height: HeightEntity.fromModel(model.height),
      gender: GenderValueObject(model.gender),
      dailyGoal: PositiveIntegerValueObject(model.dailyGoal),
    );
  }

  ProfileModel toModel() {
    return ProfileModel(
      name: name.getOrNull,
      height: height.toModel(),
      gender: gender.getOrNull,
      dailyGoal: dailyGoal.getOrNull,
    );
  }

  final StringNonEmptyValueObject name;
  final HeightEntity height;
  final GenderValueObject gender;
  final PositiveIntegerValueObject dailyGoal;

  @override
  bool get valid => true;

  @override
  List<IValidable> get props => [name, height, gender, dailyGoal];
}
