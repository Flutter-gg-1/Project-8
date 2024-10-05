part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class UpdateNameEvent extends ProfileEvent {
  final String name;

  UpdateNameEvent(this.name);
}

class UpdatePhoneEvent extends ProfileEvent {
  final String phone;

  UpdatePhoneEvent(this.phone);
}

class UpdateImageEvent extends ProfileEvent {
  final File? image;

  UpdateImageEvent(this.image);
}

class SaveProfileEvent extends ProfileEvent {}
