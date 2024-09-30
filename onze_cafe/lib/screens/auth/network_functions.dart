import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:onze_cafe/screens/auth/auth_cubit.dart';

import '../../supabase/supabase_auth.dart';

extension NetworkFunctions on AuthCubit {
  // Sign Up

  Future signUp(BuildContext context) async {
    try {
      final response = await SupabaseAuth.createAccount(
          emailController.text, passwordController.text);
      if (context.mounted) {
        showSnackBar(
            context, response.toString(), AnimatedSnackBarType.success);
      }
      await Future.delayed(Duration(seconds: 1));
      toggleIsOtp();
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }

  // Sign In

  Future signIn(BuildContext context) async {
    try {
      final response = await SupabaseAuth.signIn(
          emailController.text, passwordController.text);

      if (context.mounted) {
        showSnackBar(
            context, response.toString(), AnimatedSnackBarType.success);
      }
      await Future.delayed(Duration(seconds: 1));
      if (context.mounted) navigateToMenu(context);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }

  // Anonymous

  Future anonymousSignIn(context) async {
    try {
      final response = await SupabaseAuth.anonymousSignIn();
      if (context.mounted) {
        showSnackBar(
            context, response.toString(), AnimatedSnackBarType.success);
      }
      await Future.delayed(Duration(seconds: 1));
      if (context.mounted) navigateToMenu(context);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }

  // OTP

  Future verifyOtp(context) async {
    var stringOtp = '$otp'.padLeft(6, '0');
    try {
      final response = await SupabaseAuth.verifyOtp(
          email: emailController.text, otp: stringOtp);
      if (context.mounted) {
        showSnackBar(
            context, response.toString(), AnimatedSnackBarType.success);
      }
      await Future.delayed(Duration(seconds: 1));
      if (context.mounted) navigateToMenu(context);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }
}
