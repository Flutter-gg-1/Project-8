import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:onze_cafe/model/profile.dart';
import 'package:onze_cafe/screens/auth/auth_cubit.dart';
import 'package:onze_cafe/supabase/supabase_profile.dart';

import '../../supabase/client/supabase_mgr.dart';
import '../../supabase/supabase_auth.dart';

extension NetworkFunctions on AuthCubit {
  // Sign Up

  Future signUp(BuildContext context) async {
    emitLoading();
    try {
      final response = await SupabaseAuth.createAccount(
          emailController.text, passwordController.text);
      if (context.mounted) {
        showSnackBar(
            context, response.toString(), AnimatedSnackBarType.success);
      }
      emitUpdate();

      toggleIsOtp();
    } catch (e) {
      emitUpdate();
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }

  // Sign In

  Future signIn(BuildContext context) async {
    try {
      emitLoading();
      final response = await SupabaseAuth.signIn(
          emailController.text, passwordController.text);

      if (context.mounted) {
        showSnackBar(
            context, response.toString(), AnimatedSnackBarType.success);
      }
      await Future.delayed(Duration(milliseconds: 50));

      await SupabaseMgr.shared.setCurrentUser();
      if (context.mounted) {
        if (SupabaseMgr.shared.currentProfile?.role == 'employee') {
          navigateToDashboard(context);
        } else {
          navigateToMenu(context);
        }
      }
      emitUpdate();
    } catch (e) {
      emitUpdate();

      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }

  // Anonymous

  Future anonymousSignIn(context) async {
    try {
      emitLoading();
      final response = await SupabaseAuth.anonymousSignIn();
      if (context.mounted) {
        showSnackBar(
            context, response.toString(), AnimatedSnackBarType.success);
      }
      await Future.delayed(Duration(milliseconds: 50));

      await SupabaseMgr.shared.setCurrentUser();

      if (context.mounted) navigateToMenu(context);
    } catch (e) {
      emitUpdate();
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }

  // OTP

  Future verifyOtp(context) async {
    var stringOtp = '$otp'.padLeft(6, '0');
    try {
      emitLoading();
      await SupabaseAuth.verifyOtp(email: emailController.text, otp: stringOtp);
      if (context.mounted) {
        showSnackBar(context, 'Otp verified. Creating user profile',
            AnimatedSnackBarType.success);
      }
      // Create Profile
      await SupabaseProfile.createProfile(Profile(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text));

      if (context.mounted) {
        showSnackBar(context, 'Profile Created. Getting things ready...',
            AnimatedSnackBarType.success);
      }

      await SupabaseMgr.shared.setCurrentUser();

      if (context.mounted) {
        if (SupabaseMgr.shared.currentProfile?.role == 'employee') {
          navigateToDashboard(context);
        } else {
          navigateToMenu(context);
        }
      }
    } catch (e) {
      emitUpdate();
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }
}
