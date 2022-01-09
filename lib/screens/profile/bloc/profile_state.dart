part of 'profile_bloc.dart';

@immutable
abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}
class ProfileLoadingState extends ProfileStates {}
class ProfileSuccessState extends ProfileStates {
  final ProfileModel profileModel;

  ProfileSuccessState(this.profileModel);
}
class ProfileErrorState extends ProfileStates {
  final String error;

  ProfileErrorState(this.error);
}
