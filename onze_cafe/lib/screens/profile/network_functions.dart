import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/profile/profile_cubit.dart';

import '../../supabase/supabase_auth.dart';
import '../landing/landing_screen.dart';

extension NetworkFunctions on ProfileCubit {
  Future signOut(BuildContext context) async {
    try {
      emitLoading();
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
      emitUpdate();
    } catch (e) {
      emitUpdate();
      if (context.mounted) {
        showSnackBar(context, 'Failed to Sign-out', AnimatedSnackBarType.error);
      }
    }
  }
}
