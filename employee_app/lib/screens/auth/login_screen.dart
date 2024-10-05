import 'dart:developer';

import 'package:employee_app/helper/extinsion/loading_dialog.dart';
import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:employee_app/screens/auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:employee_app/screens/home_screen.dart';
import 'package:employee_app/widget/add_product/custome_text_form_field.dart';
import 'package:employee_app/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        return Form(
          key: cubit.formKey,
          child: BlocListener<AuthCubit, AuthState>(
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

                log("very good login");
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const HomeScreen()));
              }
            },
            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset('assets/image/logo.png'),
                      context.addSpacer(multiply: 0.04),
                      const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3D6B7D)),
                      ),
                      context.addSpacer(multiply: 0.02),
                      Column(
                        children: [
                          SizedBox(
                            width: context.getWidth(multiply: 0.8),
                            child: CustomTextFormFelid(
                              horizontal: 2,
                              readOnly: false,
                              controller: cubit.emailCon,
                              label: 'E-mail',
                              keyboardType: TextInputType.emailAddress,
                              hint: 'example@gmail.com',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text('Please enter an email address'),
                                    backgroundColor: Colors.red,
                                  ));

                                  return "";
                                } else if (!RegExp(
                                        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                    .hasMatch(value)) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Please enter a valid email address'),
                                    backgroundColor: Colors.red,
                                  ));

                                  return "";
                                }
                                return null;
                              },
                            ),
                          ),
                          context.addSpacer(multiply: 0.02),
                          SizedBox(
                            width: context.getWidth(multiply: 0.8),
                            child: CustomTextFormFelid(
                              horizontal: 3,
                              readOnly: false,
                              controller: cubit.passCon,
                              label: 'password',
                              keyboardType: TextInputType.name,
                              hint: '',
                            ),
                          ),
                          context.addSpacer(multiply: 0.02),
                        ],
                      ),
                      context.addSpacer(multiply: 0.02),
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
          ),
        );
      }),
    );
  }
}
