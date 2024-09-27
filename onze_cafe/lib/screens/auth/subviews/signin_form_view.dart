import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/reusable_components/custom_text_field.dart';
import 'package:onze_cafe/screens/auth/auth_cubit.dart';
import 'package:onze_cafe/utils/validations.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key, required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Text('Sign In'),
          ),
          CustomTextField(
              hintText: 'Email',
              controller: TextEditingController(),
              validation: Validations.none),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomTextField(
                  hintText: 'Password',
                  controller: TextEditingController(),
                  validation: Validations.none),
              IconButton(
                  onPressed: () => (), icon: const Icon(CupertinoIcons.eye))
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => cubit.navigateToMenu(context),
                  child: const Text('Navigate to Menu'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text("Don't have an account"),
              TextButton(
                  onPressed: cubit.toggleIsSignUp, child: const Text('Sign Up'))
            ],
          )
        ],
      ),
    );
  }
}
