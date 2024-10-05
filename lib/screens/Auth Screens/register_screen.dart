import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/screens/Auth%20Screens/auth_bloc/auth_bloc.dart';
import 'package:onze_cafe/screens/Auth%20Screens/login_screen.dart';
import 'package:onze_cafe/screens/Auth%20Screens/otp_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AuthBloc>();
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SuccessfulRegisterState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OtpScreen(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                            )));
              }
              if (state is ErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/Home.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      const Text('Name',
                          style: TextStyle(
                              fontSize: 14.33,
                              color: Color(0xffE6E2E0),
                              fontWeight: FontWeight.w600)),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffA4A4A4).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: nameController,
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
                            prefixIcon: const Icon(Icons.person_2_outlined,
                                color: Color(0xffE6E2E0)),
                            hintText: 'First and last name',
                            hintStyle:
                                const TextStyle(color: Color(0xffA4A4A4)),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text('email',
                          style: TextStyle(
                              fontSize: 14.33,
                              color: Color(0xffE6E2E0),
                              fontWeight: FontWeight.w600)),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffA4A4A4).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: emailController,
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
                      const Text('Phone',
                          style: TextStyle(
                              fontSize: 14.33,
                              color: Color(0xffE6E2E0),
                              fontWeight: FontWeight.w600)),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffA4A4A4).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: phoneController,
                          keyboardType: const TextInputType.numberWithOptions(),
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
                            prefixIcon: const Icon(Icons.phone_android,
                                color: Color(0xffE6E2E0)),
                            hintText: '05xxxxxxxx',
                            hintStyle:
                                const TextStyle(color: Color(0xffA4A4A4)),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
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
                              borderRadius: BorderRadius.circular(15)),
                          child: Material(
                            type: MaterialType.transparency,
                            child: Center(
                              child: SizedBox.expand(
                                child: ElevatedButton(
                                  onPressed: () {
                                    bloc.add(RegisterEvent(
                                        email: emailController.text,
                                        password: passwordController.text));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const Text(
                                    'Register',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xff3d6b7d),
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
                                          const LoginScreen()));
                            },
                            child: RichText(
                                text: const TextSpan(children: [
                              TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 133, 60, 52))),
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
