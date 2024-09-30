import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/screen_size.dart';
import 'package:onze_cafe/screens/auth/subviews/animated_forms.dart';
import 'package:onze_cafe/screens/auth/subviews/otp_form_view.dart';

import 'auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.isSignup});

  final bool isSignup;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(isSignup),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        final brightness = Theme.of(context).brightness;
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
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
                          return cubit.isOtp
                              ? OtpFormView(cubit: cubit)
                              : AnimatedForms(cubit: cubit);
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 500), // Adjust duration
                      switchInCurve:
                          Curves.easeInOut, // Smoothing curve for transition
                      switchOutCurve: Curves.easeInOut,
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(
                                1.0, 0.0), // Start the slide from the right
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: !cubit.isSignup
                          ? Row(
                              key: ValueKey(
                                  'image1'), // Unique key for each image
                              children: [
                                Image(
                                  image: Img.illustration1,
                                  fit: BoxFit.contain,
                                  width: context.screenWidth * 0.6,
                                ),
                              ],
                            )
                          : Row(
                              key: ValueKey(
                                  'image2'), // Unique key for each image
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image(
                                  image: Img.illustration7,
                                  fit: BoxFit.contain,
                                  width: context.screenWidth * 0.4,
                                ),
                              ],
                            ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
