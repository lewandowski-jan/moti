import 'package:moti/architecture/data/model.dart';
import 'package:moti/features/measurements/data/models/measurement_model.dart';
import 'package:moti/features/profile/domain/gender_value_object.dart';

class ProfileModel extends Model {
  ProfileModel({
    required this.name,
    required this.gender,
    required this.height,
    required this.dailyGoal,
  });

  factory ProfileModel.fromJson(Map<dynamic, dynamic> json) {
    return ProfileModel(
      name: json['name'] is String ? json['name'] as String : null,
      gender: json['gender'] is String
          ? Gender.fromString(json['gender'] as String)
          : null,
      height: json['height'] is Map<dynamic, dynamic>
          ? MeasurementModel.fromJson(json['height'] as Map<dynamic, dynamic>)
          : null,
      dailyGoal: json['dailyGoal'] is int ? json['dailyGoal'] as int : null,
    );
  }

  final String? name;
  final Gender? gender;
  final MeasurementModel? height;
  final int? dailyGoal;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender?.toString(),
      'height': height?.toJson(),
      'dailyGoal': dailyGoal,
    };
  }
}
