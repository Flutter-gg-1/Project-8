import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';

part 'profile_event.dart';
part 'profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  String name;
  String phone;
  File? image;

  ProfileBloc(DataLayer dataLayer)
      : name = dataLayer.user!.name, // Initialize name from DataLayer
        phone = dataLayer.user!.phone, // Initialize phone from DataLayer
        super(ProfileInitialState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is UpdateNameEvent) {
      name = event.name;
    } else if (event is UpdatePhoneEvent) {
      phone = event.phone;
    } else if (event is UpdateImageEvent) {
      image = event.image;
    } else if (event is SaveProfileEvent) {
      yield ProfileLoadingState();
      try {
        // Simulate saving the profile (you can implement actual save logic)
        await Future.delayed(Duration(seconds: 1));
        yield ProfileUpdatedState();
      } catch (e) {
        yield ProfileErrorState("Failed to save profile");
      }
    }
  }
}
