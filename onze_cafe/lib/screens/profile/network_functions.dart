import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/profile/profile_cubit.dart';
import 'package:onze_cafe/supabase/client/supabase_mgr.dart';
import 'package:onze_cafe/supabase/supabase_profile.dart';

import '../../model/profile.dart';
import '../../supabase/supabase_auth.dart';
import '../landing/landing_screen.dart';

extension NetworkFunctions on ProfileCubit {
  Future<Profile?> fetchProfile(BuildContext context) async {
    try {
      var profile = await SupabaseProfile.fetchProfile(
          SupabaseMgr.shared.currentUser?.id ?? '');
      if (context.mounted) {
        showSnackBar(
            context, 'Finished loading profile', AnimatedSnackBarType.success);
      }
      return profile;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(
            context, 'Failed to Load Profile', AnimatedSnackBarType.error);
      }
    }
    return null;
  }

  Future signOut(BuildContext context) async {
    try {
      await SupabaseAuth.signOut();

      if (context.mounted) {
        showSnackBar(context, 'Signed out', AnimatedSnackBarType.success);
      }

      await Future.delayed(Duration(milliseconds: 50));

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LandingScreen()),
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Failed to Sign-out', AnimatedSnackBarType.error);
      }
    }
  }
}
