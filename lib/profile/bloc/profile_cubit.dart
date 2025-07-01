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
  Future<void> updateUser(
      String uid,
      String? name) async{
   emit(ProfileStateLoading());
   try{
     final user = await profileRepo.fetchUserProfile(uid);
     if (user == null){
       emit(ProfileStateError(error: 'no current user'));
       return;
     }
     final updatedProfile = user.copyWith(name: name ?? user.name);

     await profileRepo.updateProfile(updatedProfile);

     await profileRepo.fetchUserProfile(uid);
   } catch (e){
     emit(ProfileStateError(error: 'error: $e'));
   }
  }
}
