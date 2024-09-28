import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/screens/Auth%20Screens/auth_bloc/auth_bloc.dart';
import 'package:onze_cafe/screens/Auth%20Screens/register_screen.dart';
import 'package:onze_cafe/screens/Home%20Screen/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AuthBloc>();
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SuccessfulLoginState) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            }
            if (state is ErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Scaffold(
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/login_background.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(color: Colors.white, fontSize: 14.33),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffA4A4A4).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xffE6E2E0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xffE6E2E0),
                                width: 2,
                              ),
                            ),
                            prefixIcon: const Icon(
                                Icons.alternate_email_outlined,
                                color: Color(0xffE6E2E0)),
                            hintText: 'example@gmail.com',
                            hintStyle:
                                const TextStyle(color: Color(0xffA4A4A4)),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text('Password',
                          style: TextStyle(
                              fontSize: 14.33,
                              color: Color(0xffE6E2E0),
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffA4A4A4).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          cursorColor: const Color(0xffE6E2E0),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xffE6E2E0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xffE6E2E0),
                                width: 2,
                              ),
                            ),
                            prefixIcon:
                                const Icon(Icons.key, color: Color(0xffE6E2E0)),
                            suffixIcon: const Icon(Icons.visibility_off,
                                color: Color(0xffE6E2E0)),
                            hintText: '•••••••••',
                            hintStyle:
                                const TextStyle(color: Color(0xffA4A4A4)),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // forgot password??
                            },
                            child: const Text('Forgot Password',
                                style: TextStyle(color: Color(0xff87B1C5))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                          height: 50,
                          width: 314,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xffE6E2E0), width: 1),
                              gradient: const LinearGradient(colors: [
                                Color(0xff2F4B4E),
                                Color(0xffE6E2E0)
                              ]),
                              borderRadius: BorderRadius.circular(15)),
                          child: Material(
                            type: MaterialType.transparency,
                            child: Center(
                              child: SizedBox.expand(
                                child: ElevatedButton(
                                  onPressed: () {
                                    bloc.add(LoginEvent(
                                        email: emailController.text,
                                        password: passwordController.text));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const Text(
                                    'Sign in',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.92,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen()));
                            },
                            child: RichText(
                                text: const TextSpan(children: [
                              TextSpan(text: 'Don\'t have an account? '),
                              TextSpan(
                                  text: 'Register',
                                  style: TextStyle(color: Color(0xff87B1C5))),
                            ]))),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
