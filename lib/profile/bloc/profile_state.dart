
import '../../features/domain/entity/app_user.dart';

abstract class ProfileState {}

class ProfileStateInitial extends ProfileState{}

class ProfileStateLoading extends ProfileState{}

class ProfileStateLoaded extends ProfileState{
  final AppUser user;

  ProfileStateLoaded({required this.user});
}

class ProfileStateError extends ProfileState{
  final String error;

  ProfileStateError({required this.error});
}