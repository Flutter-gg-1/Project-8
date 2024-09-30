import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/screens/menu/menu_screen.dart';

import '../../servers/setup.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailSignInController = TextEditingController();
  final TextEditingController passwordSignInController =
      TextEditingController();

  void navigateToMenu(BuildContext context) =>
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MenuScreen()));

  bool isSignup = false;

  void initialLoad(bool isSignUp) {
    print(isSignUp);
    isSignUp = isSignUp;
    emit(UpdateUIState());
  }

  Future logWithOtp() async {
    print('object');
    try {
      await supabase.auth.signInWithOtp(email: emailSignInController.text);
      print("OTP sent");
    } catch (e) {
      print(e.toString());
    }
  }

  void toggleIsSignUp() {
    isSignup = !isSignup;
    emit(UpdateUIState());
  }
}
