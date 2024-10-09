
import 'package:customer_app/helper/extinsion/loading_dialog.dart';
import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/screens/auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:customer_app/screens/auth/signup_screen.dart';
import 'package:customer_app/screens/home/home_screen.dart';

import 'package:customer_app/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  final String? fName;
  final String? lName;
  const OtpScreen({super.key, required this.email, this.fName, this.lName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is NoLoadingState) {
              Navigator.pop(context);
            }

            if (state is ErrorState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.msg,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.red,
              ));
            }

            if (state is LoadingState) {
              context.showLoadingDialog();
            }

            if (state is SuccessState) {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
            }
          },
          child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: context.getWidth(multiply: 0.06)),
                child: Column(
                  children: [
                    Image.asset('assets/image/logo.png'),
                    context.addSpacer(multiply: 0.04),
                    const Text(
                      'OTP',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3D6B7D)),
                    ),
                    context.addSpacer(multiply: 0.02),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'E-mail : $email',
                          style: const TextStyle(
                              color: Color(0xff87B1C5),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                    context.addSpacer(multiply: 0.02),
                    Pinput(
                      length: 6,
                      onCompleted: (value) {
                        cubit.otp = value;
                      },
                    ),
                    context.addSpacer(multiply: 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don’t send OTP?',
                          style:
                              TextStyle(color: Color(0xff87B1C5), fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ));
                          },
                          child: const Text(
                            'ResendOTP',
                            style: TextStyle(
                                color: Color(0xffA8483D),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    context.addSpacer(multiply: 0.04),
                    CustomButton(
                      title: 'Verify',
                      onPressed: () {
                        cubit.otpCheck(
                            email: email, fName: fName, lName: lName);
                      },
                      icon: Icons.arrow_forward_ios_rounded,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
