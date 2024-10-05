part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileUpdatedState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState(this.error);
}
