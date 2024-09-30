import 'package:onze_cafe/screens/auth/auth_cubit.dart';

import '../../supabase/supabase_auth.dart';

extension NetworkFunctions on AuthCubit {
  // Sign Up

  Future signUp() async {
    try {
      final response = await SupabaseAuth.createAccount(
          emailController.text, passwordController.text);
      print('response $response');
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign In

  Future signIn() async {
    try {
      final response = await SupabaseAuth.signIn(
          emailController.text, passwordController.text);
      print('response $response');
    } catch (e) {
      print(e.toString());
    }
  }

  // Anonymous

  Future anonymousSignIn() async {
    try {
      final response = await SupabaseAuth.anonymousSignIn();
      print('response $response');
    } catch (e) {
      print(e.toString());
    }
  }
}
