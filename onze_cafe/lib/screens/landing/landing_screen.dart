import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/reusable_components/buttons/primary_btn_view.dart';
import 'package:onze_cafe/reusable_components/buttons/secondary_btn_view.dart';
import 'package:onze_cafe/screens/landing/landing_cubit.dart';

import '../auth/auth_screen.dart';
import '../menu/menu_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToAuth(BuildContext context, bool isSignup) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AuthScreen(isSignup: isSignup)));

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BlocProvider(
      create: (context) => LandingCubit(),
      child: BlocListener<LandingCubit, LandingState>(
        listener: (context, state) {
          if (state is UserSessionExists) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MenuScreen()));
          }
        },
        child: Scaffold(
          backgroundColor: C.bg1(brightness),
          body: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image(image: Img.animatedOnze, fit: BoxFit.contain),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(image: Img.logo3, fit: BoxFit.contain),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: PrimaryBtnView(
                                    title: 'Sign In',
                                    callback: () =>
                                        navigateToAuth(context, false)),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SecondaryBtnView(
                                  title: 'Sign Up',
                                  callback: () =>
                                      navigateToAuth(context, true)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
