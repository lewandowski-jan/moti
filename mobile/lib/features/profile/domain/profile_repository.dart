import 'package:moti/features/profile/data/profile_service.dart';
import 'package:moti/features/profile/domain/profile_entity.dart';

class ProfileRepository {
  const ProfileRepository({
    required this.profileService,
  });

  final ProfileService profileService;

  ProfileEntity getProfile() {
    final model = profileService.getProfile();

    return ProfileEntity.fromModel(model);
  }

  Future<void> saveProfile(ProfileEntity profile) {
    return profileService.saveProfile(profile.toModel());
  }
}
