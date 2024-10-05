import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/screen_size.dart';
import 'package:onze_cafe/managers/alert_mgr.dart';
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
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoadingState) {
              AlertManager().showAlert(context: context);
            } else if (state is UpdateUIState) {
              AlertManager().dismissPreviousAlert(context);
            }
          },
          
            
            child: Scaffold(
              backgroundColor: C.bg1(brightness),
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Image(
                        image: Img.logo3,
                        fit: BoxFit.contain,
                        width: context.screenWidth * 0.4,
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
                          duration:
                              Duration(milliseconds: 500), // Adjust duration
                          switchInCurve: Curves
                              .easeInOut, // Smoothing curve for transition
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
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    key: ValueKey(
                                        'image1'), // Unique key for each image
                                    children: [
                                      Image(
                                        image: Img.illustration12,
                                        fit: BoxFit.contain,
                                        width: context.screenWidth * 0.5,
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    key: ValueKey(
                                        'image2'), // Unique key for each image
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image(
                                        image: Img.illustration13,
                                        fit: BoxFit.contain,
                                        width: context.screenWidth * 0.4,
                                      ),
                                    ],
                                  ),
                                ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          
        );
      }),
    );
  }
}
