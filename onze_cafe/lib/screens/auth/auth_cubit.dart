import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/screens/menu/menu_screen.dart';

import '../../reusable_components/animated_snackbar.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(bool isSignUp) : super(AuthInitial()) {
    initialLoad(isSignUp);
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  int otp = -1;

  void navigateToMenu(BuildContext context) =>
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MenuScreen()));

  bool isOtp = false;
  bool isSignup = false;

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }

  void initialLoad(bool isSignUp) async {
    isSignup = isSignUp;
    Future.delayed(Duration(milliseconds: 50));
    emit(UpdateUIState());
  }

  void toggleIsSignUp() {
    isSignup = !isSignup;
    emit(UpdateUIState());
  }

  void toggleIsOtp() {
    isOtp = !isOtp;
    emit(UpdateUIState());
  }
}
