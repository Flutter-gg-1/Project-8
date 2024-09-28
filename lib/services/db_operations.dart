import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/services/setup.dart';
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

Future login({required String email, required String password}) async {
  try {
    final authRes = await supabase.auth
        .signInWithPassword(email: email, password: password);
    Map<String, dynamic> user =
        await locator.get<DataLayer>().getUserById(email: email);
    locator
        .get<DataLayer>()
        .saveAuth(token: authRes.session!.accessToken, user: user);
    return authRes;
  } catch (error) {
    return Future.error(error);
  }
}

Future verify(
    {required String email,
    required String otp,
    required String name,
    required String phone}) async {
  try {
    final authRes = await supabase.auth
        .verifyOTP(type: OtpType.signup, email: email, token: otp);

    await supabase.from('app_user').insert({
      'user_id': authRes.user?.id,
      'name': name,
      'email': email,
      'phone': phone,
    });
    return authRes;
  } catch (error) {
    return Future.error(error);
  }
}
