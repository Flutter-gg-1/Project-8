import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/custom_text_field.dart';
import 'package:onze_cafe/reusable_components/buttons/primary_btn_view.dart';
import 'package:onze_cafe/screens/auth/auth_cubit.dart';
import 'package:onze_cafe/screens/auth/network_functions.dart';
import 'package:onze_cafe/utils/validations.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key, required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Text('Sign In').styled(
                size: 22,
                color: C.secondary(brightness),
                weight: FontWeight.bold),
          ),
          CustomTextField(
              hintText: 'Email',
              controller: cubit.emailController,
              validation: Validations.none),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomTextField(
                  hintText: 'Password',
                  controller: cubit.passwordController,
                  validation: Validations.none),
              IconButton(
                  onPressed: () => (),
                  icon:
                      Icon(CupertinoIcons.eye, color: C.secondary(brightness)))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryBtnView(
                    title: 'Log In',
                    callback: () => cubit.signIn(context),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Text("Don't have an account")
                  .styled(weight: FontWeight.w500),
              TextButton(
                  onPressed: cubit.toggleIsSignUp,
                  child: const Text('Sign Up').styled(
                      weight: FontWeight.w500, color: C.secondary(brightness)))
            ],
          ),
          Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () => cubit.anonymousSignIn(context),
                child: const Text('Continue as guest').styled(
                  weight: FontWeight.w500,
                  color: C.secondary(brightness),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
