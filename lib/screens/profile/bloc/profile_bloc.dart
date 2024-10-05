import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';

part 'profile_event.dart';
part 'profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  String name;
  String phone;
  File? image;

  ProfileBloc(DataLayer dataLayer)
      : name = dataLayer.user!.name,
        phone = dataLayer.user!.phone,
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
        await Future.delayed(const Duration(seconds: 1));
        yield ProfileUpdatedState();
      } catch (e) {
        yield ProfileErrorState("Failed to save profile");
      }
    }
  }
}
