import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/screens/profile/network_functions.dart';

import '../../model/profile.dart';
import '../../reusable_components/animated_snackbar.dart';
import '../edit_profile/edit_profile_screen.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(BuildContext context) : super(ProfileInitial()) {
    loadProfile(context);
  }

  Profile? profile;

  loadProfile(context) async {
    profile = await fetchProfile(context);
    emit(UpdateUIState());
  }

  navigateToEditProfile(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditProfileScreen(profile: profile)));

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }
}
