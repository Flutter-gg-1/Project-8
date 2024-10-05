import 'dart:developer';

import 'package:employee_app/DB/super.dart';
import 'package:employee_app/data_layer/auth_layer.dart';
import 'package:employee_app/models/user_model.dart';
import 'package:employee_app/services/setup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

mixin AuthMix on Super {
  createLogin({required String email}) async {
    try {
      await supabase.auth.signInWithOtp(email: email);
    } catch (er) {
      log("error in createLogin");
      log("$er");

      throw "$er";
    }
  }

  empLogin({required String email, required String pass}) async{


      try {
     final auth = await supabase.auth.signInWithPassword(email: email ,password: pass);



       log("in the user login");
        final emp = await supabase
            .from('employee')
            .select()
            .eq('auth_id', auth.user!.id);

        log("$emp");

        final user = UserModel(
            customerId: emp[0]['employee_id'],
            email: auth.user!.email!,
            firstName: emp[0]['first_name'],
            lastName: emp[0]['last_name']);

        log("userModel from new user");

        productLocator.get<AuthLayer>().saveAuth(userData: user);

        log("${user.toJson()}");





    } catch (er) {
      log("error in createLogin");
      log("$er");

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
        log("in new user create");
        final customer = await supabase.from('customer').insert({
          "first_name": fName,
          'last_name': lName,
          'auth_id': auth.user!.id
        }).select();

        log(customer.toString());

        final user = UserModel(
            customerId: customer[0]['customer_id'],
            email: auth.user!.email!,
            firstName: customer[0]['first_name'],
            lastName: customer[0]['last_name']);

        log("userModel from login user");

        productLocator.get<AuthLayer>().userGiveVal(userModel: user);

        log("${user.toJson()}");
      } else {
        log("in the user login");
        final customer = await supabase
            .from('customer')
            .select()
            .eq('auth_id', auth.user!.id);

        log("$customer");

        final user = UserModel(
            customerId: customer[0]['customer_id'],
            email: auth.user!.email!,
            firstName: customer[0]['first_name'],
            lastName: customer[0]['last_name']);

        log("userModel from new user");

        productLocator.get<AuthLayer>().userGiveVal(userModel: user);

        log("${user.toJson()}");
      }

      // log("${user.session}");
      log("the user");
      // log("${user.user}");
    } catch (er) {
      log("$er");
      throw "$er";
    }
  }

  getUser() {}
}
