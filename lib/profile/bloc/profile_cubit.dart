import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qol_ber/profile/bloc/profile_state.dart';
import 'package:qol_ber/profile/repository/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileStateInitial());

  Future<void> fetchUserProfile(String uid) async{
  emit(ProfileStateLoading());
  try{
    final user = profileRepo.fetchUserProfile(uid);
    
    if (user != null){
      emit(ProfileStateLoaded(user: user));
    }else {
      emit(ProfileStateError(error: 'user not found'));
    }
  }catch (e){
    emit(ProfileStateError(error: '$e'));
  }
  }
}
