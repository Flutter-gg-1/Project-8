import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/model/profile.dart';
import 'package:onze_cafe/screens/edit_profile/edit_profile_cubit.dart';
import 'package:onze_cafe/supabase/client/supabase_mgr.dart';
import 'package:onze_cafe/supabase/supabase_profile.dart';

extension NetworkFunctions on EditProfileCubit {
  Future updateProfile(BuildContext context) async {
    try {
      emitLoading();
      await SupabaseProfile.updateProfile(
          profile: Profile(
            name: nameController.text,
            email: emailController.text,
            phone: phoneController.text,
          ),
          avatarFile: avatar);

      await SupabaseMgr.shared.setCurrentUser();

      if (context.mounted) {
        showSnackBar(context, 'Profile Update!', AnimatedSnackBarType.success);
      }
      emitUpdate();
    } catch (e) {
      emitUpdate();
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }
}
