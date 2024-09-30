import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/landing/landing_screen.dart';
import 'package:onze_cafe/supabase/supabase_auth.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future signOut(BuildContext context) async {
    try {
      await SupabaseAuth.signOut();
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LandingScreen()));
      }
    } catch (e) {
      print('');
    }
  }
}
