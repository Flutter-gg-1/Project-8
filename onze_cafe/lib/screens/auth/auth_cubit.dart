import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/screens/menu/menu_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void navigateToMenu(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const MenuScreen()));

  bool isSignup = false;

  void toggleIsSignUp() {
    isSignup = !isSignup;
    emit(UpdateUIState());
  }
}
