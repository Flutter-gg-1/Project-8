import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/screens/landing/landing_screen.dart';
import 'package:onze_cafe/supabase/supabase_auth.dart';

import '../../reusable_components/animated_snackbar.dart';
import '../edit_profile/edit_profile_screen.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  navigateToEditProfile(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              EditProfileScreen(profile: MockData().profiles.first)));

  Future signOut(BuildContext context) async {
    try {
      await SupabaseAuth.signOut();

      if (context.mounted) {
        animatedSnakbar(
                msg: 'Logout Successful', type: AnimatedSnackBarType.success)
            .show(context);
      }

      await Future.delayed(Duration(seconds: 1));

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LandingScreen()),
        );
      }
    } catch (e) {
      print('Sign-out failed: $e');
    }
  }
}
