import 'package:bloc/bloc.dart';
import 'package:employee_app/DB/super_main.dart';
import 'package:employee_app/data_layer/auth_layer.dart';
import 'package:employee_app/services/setup.dart';

import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final locator = authLocator.get<AuthLayer>();
  final db = SuperMain().supabase;
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  String otp = "";
  AuthCubit() : super(AuthInitial());

  login() async {
    try {
      emit(LoadingState());
      if (formKey.currentState!.validate()) {
        await SuperMain().empLogin(email: emailCon.text, pass: passCon.text);

        emit(SuccessState());
      } else {
        emit(NoLoadingState());
      }
    } catch (er) {
      emit(ErrorState(msg: er.toString()));
    }
  }

  
  
}
