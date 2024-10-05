import 'package:customer_app/DB/super.dart';
import 'package:customer_app/data_layer/auth_layer.dart';
import 'package:customer_app/models/user_model.dart';
import 'package:customer_app/services/setup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

mixin AuthMix on Super {
  createLogin({required String email}) async {
    try {
      await supabase.auth.signInWithOtp(email: email);
    } catch (er) {
      throw "$er";
    }
  }

  verifyOtp(
      {required String email,
      required String otp,
      required String? fName,
      required String? lName}) async {
    try {
      final auth = await supabase.auth
          .verifyOTP(type: OtpType.email, email: email, token: otp);

      if (fName != null && lName != null) {
        final customer = await supabase.from('customer').insert({
          "first_name": fName,
          'last_name': lName,
          'auth_id': auth.user!.id
        }).select();

        final user = UserModel(
            customerId: customer[0]['customer_id'],
            email: auth.user!.email!,
            firstName: customer[0]['first_name'],
            lastName: customer[0]['last_name']);

        authLocator.get<AuthLayer>().saveAuth(userData: user);
      } else {
        final customer = await supabase
            .from('customer')
            .select()
            .eq('auth_id', auth.user!.id);

        final user = UserModel(
            customerId: customer[0]['customer_id'],
            email: auth.user!.email!,
            firstName: customer[0]['first_name'],
            lastName: customer[0]['last_name']);

        productLocator.get<AuthLayer>().saveAuth(userData: user);
      }
    } catch (er) {
      throw "$er";
    }
  }

  getUser() {}
}
