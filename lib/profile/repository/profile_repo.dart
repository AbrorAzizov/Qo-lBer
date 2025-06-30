

import '../../features/domain/entity/app_user.dart';


abstract class ProfileRepo{
  Future<AppUser?> fetchUserProfile(String uid);
  Future<void> updateProfile(AppUser updateUser);
}