import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/screens/auth/subviews/signin_form_view.dart';
import 'package:onze_cafe/screens/auth/subviews/signup_form_view.dart';

import 'auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Auth Screen'),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return ListView(
                          children: [
                            cubit.isSignup
                                ? SignupFormView(cubit: cubit)
                                : SignInForm(cubit: cubit)
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
