import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:customer_app/DB/super_main.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailCon = TextEditingController();
  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lasttNameCon = TextEditingController();

  String otp = "";
  AuthCubit() : super(AuthInitial());

  singup() async {
    try {
      emit(LodingState());
      if (formKey.currentState!.validate()) {
        await SuperMain().createLogin(email: emailCon.text);

        log('Form is valid, proceed with signup');
        emit(SucssState());
      } else {
        emit(NoLodingState());
        log('Form is invalid');
      }
    } catch (er) {
      log("in signup eorr");
      log("$er");

      emit(EorrState(msg: er.toString()));
    }
  }

  otpCheck({required String email , required String? fName , required String? lName}) async {
    try {
      emit(LodingState());
      if (otp.isEmpty) {
        emit(EorrState(msg: "enter otp first"));
        return;
      }
      

      await SuperMain().verfiyOtp(email: email, otp: otp , fName:fName ,lName: lName  );
      emit(SucssState());
    } catch (er) {
      log("$er");

      emit(EorrState(msg: er.toString()));
    }
  }
}
