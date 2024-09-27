import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future createAccount({required String email, required String password}) async {
  try {
    final AuthResponse authRes =
        await supabase.auth.signUp(email: email, password: password);
    return authRes;
  } catch (error) {
    return Future.error(error);
  }
}

Future login({required String email}) async {
  try {
    final authRes = await supabase.auth.signInWithOtp(email: email);
    return authRes;
  } catch (error) {
    return Future.error(error);
  }
}

Future verify({required String email, required String otp}) async {
  try {
    final authRes = await supabase.auth
        .verifyOTP(type: OtpType.signup, email: email, token: otp);
    return authRes;
  } catch (error) {
    return Future.error(error);
  }
}
