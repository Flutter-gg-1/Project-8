import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/auth/auth_cubit.dart';
import 'package:onze_cafe/screens/auth/subviews/signin_form_view.dart';
import 'package:onze_cafe/screens/auth/subviews/signup_form_view.dart';

class AnimatedForms extends StatelessWidget {
  const AnimatedForms({super.key, required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 500), // Adjust duration
      curve: Curves.easeInOut, // Optional: Smoothing curve
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500), // Animation duration
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0), // Start from the right
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: cubit.isSignup
            ? SignupFormView(key: ValueKey('signup'), cubit: cubit)
            : SignInForm(key: ValueKey('signin'), cubit: cubit),
      ),
    );
  }
}
