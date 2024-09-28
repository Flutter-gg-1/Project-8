import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/screen_size.dart';
import 'package:onze_cafe/screens/auth/subviews/signin_form_view.dart';
import 'package:onze_cafe/screens/auth/subviews/signup_form_view.dart';

import 'auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.isSignup});

  final bool isSignup;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        final brightness = Theme.of(context).brightness;
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          body: SafeArea(
            child: Stack(
              children: [
                // Background Images
                Align(
                  alignment: Alignment.bottomRight,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Opacity(
                        opacity: cubit.isSignup ? 1 : 0,
                        child: Image(
                          image: Img.illustration7,
                          fit: BoxFit.contain,
                          width: context.screenWidth * 0.4,
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Opacity(
                        opacity: cubit.isSignup ? 0 : 1,
                        child: Image(
                          image: Img.illustration1,
                          fit: BoxFit.contain,
                          width: context.screenWidth * 0.6,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Image(
                          image: Img.logo3,
                          fit: BoxFit.contain,
                          width: context.screenWidth * 0.5,
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                if (state is AuthInitial) {
                                  cubit.isSignup = isSignup;
                                }
                                return cubit.isSignup
                                    ? SignupFormView(cubit: cubit)
                                    : SignInForm(cubit: cubit);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
