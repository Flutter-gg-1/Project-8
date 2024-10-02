import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/screens/auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:customer_app/screens/auth/otp_screen.dart';
import 'package:customer_app/screens/auth/signup_screen.dart';
import 'package:customer_app/widget/TextFormFeild/custom_text_form_feild.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )));
            }

            if (state is SuccessState) {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpScreen(
                      email: cubit.emailCon.text,
                    ),
                  ));
            }
          },
          child: Form(
            key: cubit.formKey,
            child: Scaffold(
              // backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  children: [
                    Image.asset('assets/image/logo.png'),
                    context.addSpacer(multiply: 0.04),
                    const Text(
                      'Greeting',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3D6B7D)),
                    ),
                    context.addSpacer(multiply: 0.02),
                    CustomTextFormFelid(
                      controller: cubit.emailCon,
                      label: 'E-mail',
                      keyboardType: TextInputType.emailAddress,
                      hint: 'example@gmail.com',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Please enter an email address'),
                            backgroundColor: Colors.red,
                          ));
                          return "";
                        } else if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                            .hasMatch(value)) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Please enter a valid email address'),
                            backgroundColor: Colors.red,
                          ));
                          return "";
                        }
                        return null;
                      },
                    ),
                    context.addSpacer(multiply: 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don’t have an account?',
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
                            'Create',
                            style: TextStyle(
                              color: Color(0xff87B1C5),
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xff87B1C5),
                              decorationThickness: 2,
                            ),
                          ),
                        )
                      ],
                    ),
                    context.addSpacer(multiply: 0.04),
                    CustomButton(
                      title: 'Login',
                      onPressed: () {
                        cubit.singup();
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
