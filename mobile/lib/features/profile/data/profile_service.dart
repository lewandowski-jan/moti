import 'package:moti/core/local_storage.dart';
import 'package:moti/features/profile/data/profile_model.dart';

class ProfileService {
  const ProfileService({
    required this.profileStorage,
  });

  final LocalStorage profileStorage;

  Future<void> saveProfile(ProfileModel model) async {
    return profileStorage.add(model, 'profileKey');
  }

  ProfileModel? getProfile() {
    return profileStorage.get('profileKey', ProfileModel.fromJson);
  }
}
