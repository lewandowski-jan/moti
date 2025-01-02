import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:moti/architecture/domain/string_non_empty_value_object.dart';

import 'package:moti/architecture/domain/value_object.dart';
import 'package:moti/features/measurements/data/models/measurement_model.dart';
import 'package:moti/features/measurements/domain/height_entity.dart';
import 'package:moti/features/measurements/domain/weight_entity.dart';
import 'package:moti/features/measurements/domain/weight_repository.dart';
import 'package:moti/features/profile/domain/gender_value_object.dart';

class ProfileCubit extends HydratedCubit<ProfileState> {
  ProfileCubit({
    required this.weightRepository,
  }) : super(ProfileState.initial());

  final WeightRepository weightRepository;

  void init() {
    final lastWeight = weightRepository.getLastWeight();

    emit(state.copyWith(weight: lastWeight));
  }

  Future<void> setWeight(WeightEntity weight) async {
    await weightRepository.addWeight(weight);

    init();
  }

  void setName(String name) {
    emit(state.copyWith(name: StringNonEmptyValueObject(name)));
  }

  void setGender(Gender gender) {
    emit(state.copyWith(gender: GenderValueObject(gender)));
  }

  void setHeight(HeightEntity height) {
    emit(state.copyWith(height: height));
  }

  void setDailyGoal(int? goal) {
    emit(state.copyWith(dailyGoal: ValueObject(goal)));
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    final name = StringNonEmptyValueObject(json['name'] as String?);
    final gender = GenderValueObject(
      Gender.fromString(json['gender'] as String?),
    );
    final heightModel =
        MeasurementModel.fromJson(json['height'] as Map<String, dynamic>?);
    final height = HeightEntity.fromModel(heightModel);
    final dailyGoal = ValueObject(json['dailyGoal'] as int?);

    return ProfileState(
      name: name,
      gender: gender,
      height: height,
      dailyGoal: dailyGoal,
      weight: WeightEntity.invalid(),
    );
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    return {
      'name': state.name.value,
      'gender': state.gender.value.toString(),
      'height': state.height.toModel().toJson(),
      'dailyGoal': state.dailyGoal.value,
    };
  }
}

class ProfileState extends Equatable {
  const ProfileState({
    required this.name,
    required this.gender,
    required this.height,
    required this.weight,
    required this.dailyGoal,
  });

  factory ProfileState.initial() {
    return ProfileState(
      name: StringNonEmptyValueObject.invalid(),
      gender: GenderValueObject.invalid(),
      height: HeightEntity.invalid(),
      weight: WeightEntity.invalid(),
      dailyGoal: ValueObject.invalid(),
    );
  }

  final StringNonEmptyValueObject name;
  final GenderValueObject gender;
  final HeightEntity height;
  final WeightEntity weight;
  final ValueObject<int> dailyGoal;

  ProfileState copyWith({
    StringNonEmptyValueObject? name,
    GenderValueObject? gender,
    HeightEntity? height,
    WeightEntity? weight,
    ValueObject<int>? dailyGoal,
  }) {
    return ProfileState(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      dailyGoal: dailyGoal ?? this.dailyGoal,
    );
  }

  @override
  List<Object?> get props => [name, gender, height, weight, dailyGoal];
}
