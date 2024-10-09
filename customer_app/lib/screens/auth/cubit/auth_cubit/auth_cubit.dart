import 'package:bloc/bloc.dart';
import 'package:customer_app/DB/super_main.dart';
import 'package:customer_app/data_layer/auth_layer.dart';
import 'package:customer_app/services/setup.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final locator = authLocator.get<AuthLayer>();
  final db = SuperMain().supabase;
  TextEditingController emailCon = TextEditingController();
  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();

  String otp = "";
  AuthCubit() : super(AuthInitial());

  singup() async {
    try {
      emit(LoadingState());
      if (formKey.currentState!.validate()) {
        await SuperMain().createLogin(email: emailCon.text);

        emit(SuccessState());
      } else {
        emit(NoLoadingState());
      }
    } catch (er) {
      emit(ErrorState(msg: er.toString()));
    }
  }

  otpCheck(
      {required String email,
      required String? fName,
      required String? lName}) async {
    try {
      emit(LoadingState());
      if (otp.isEmpty) {
        emit(ErrorState(msg: "enter otp first"));
        return;
      }

      await SuperMain()
          .verifyOtp(email: email, otp: otp, fName: fName, lName: lName);

      emit(SuccessState());
    } catch (er) {
      emit(ErrorState(msg: er.toString()));
    }
  }
}
