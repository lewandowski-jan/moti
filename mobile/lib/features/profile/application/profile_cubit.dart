import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_comms/flutter_comms.dart';
import 'package:moti/architecture/domain/positive_integer_value_object.dart';
import 'package:moti/architecture/domain/string_non_empty_value_object.dart';

import 'package:moti/features/measurements/domain/height_entity.dart';
import 'package:moti/features/measurements/domain/weight_entity.dart';
import 'package:moti/features/measurements/domain/weight_repository.dart';
import 'package:moti/features/profile/domain/gender_value_object.dart';
import 'package:moti/features/profile/domain/profile_entity.dart';
import 'package:moti/features/profile/domain/profile_repository.dart';

enum ProfileMessage {
  profileUpdated;
}

class ProfileCubit extends Cubit<ProfileState> with Sender<ProfileMessage> {
  ProfileCubit({
    required this.weightRepository,
    required this.profileRepository,
  }) : super(ProfileState.initial());

  final WeightRepository weightRepository;
  final ProfileRepository profileRepository;

  void init() {
    final lastWeight = weightRepository.getLastWeight();
    final profile = profileRepository.getProfile();

    emit(
      state.copyWith(
        weight: lastWeight,
        name: profile.name,
        dailyGoal: profile.dailyGoal,
        height: profile.height,
        gender: profile.gender,
      ),
    );
  }

  var _weight = WeightEntity.invalid();

  Future<void> setWeight(WeightEntity weight) async {
    _weight = weight;
  }

  Future<void> onWeightSubmitted() async {
    await weightRepository.addWeight(_weight);
    _weight = WeightEntity.invalid();

    init();
  }

  Future<void> onProfileSubmitted() async {
    await profileRepository.saveProfile(
      ProfileEntity(
        name: state.name,
        gender: state.gender,
        height: state.height,
        dailyGoal: state.dailyGoal,
      ),
    );

    send(ProfileMessage.profileUpdated);

    init();
  }

  void setName(String name) {
    emit(state.copyWith(name: StringNonEmptyValueObject(name)));
  }

  void setGender(GenderValueObject gender) {
    emit(state.copyWith(gender: gender));
  }

  void setHeight(HeightEntity height) {
    emit(state.copyWith(height: height));
  }

  void setDailyGoal(int? goal) {
    emit(state.copyWith(dailyGoal: PositiveIntegerValueObject(goal)));
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
      dailyGoal: PositiveIntegerValueObject.invalid(),
    );
  }

  final StringNonEmptyValueObject name;
  final GenderValueObject gender;
  final HeightEntity height;
  final WeightEntity weight;
  final PositiveIntegerValueObject dailyGoal;

  ProfileState copyWith({
    StringNonEmptyValueObject? name,
    GenderValueObject? gender,
    HeightEntity? height,
    WeightEntity? weight,
    PositiveIntegerValueObject? dailyGoal,
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
