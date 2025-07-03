import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qol_ber/profile/bloc/profile_state.dart';
import 'package:qol_ber/profile/repository/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileStateInitial());

  Future<void> fetchUser(String uid) async{
  emit(ProfileStateLoading());
  try{
    final user = await profileRepo.fetchUserProfile(uid);

    if (user != null){
      emit(ProfileStateLoaded(user: user));
    }else {
      emit(ProfileStateError(error: 'user not found'));
    }
  }catch (e){
    emit(ProfileStateError(error: '$e'));
  }
  }


  Future<void> updateUser({
    required String uid,
    String? name,
    String? bio,
    String? photoUrl,
  }) async{
   emit(ProfileStateLoading());
   try{
     final user = await profileRepo.fetchUserProfile(uid);
     if (user == null){
       emit(ProfileStateError(error: 'no current user'));
       return;
     }
     final updatedProfile = user.copyWith(name: name ,bio: bio ,photoUrl:photoUrl,);

     await profileRepo.updateProfile(updatedProfile);

     final refreshedUser = await profileRepo.fetchUserProfile(uid);
     if (refreshedUser != null) {
       emit(ProfileStateLoaded(user: refreshedUser));
     } else {
       emit(ProfileStateError(error: 'Failed to reload updated user'));
     }
;
   } catch (e){
     emit(ProfileStateError(error: 'error: $e'));
   }
  }
}
