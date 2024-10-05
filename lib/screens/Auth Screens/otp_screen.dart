import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/screens/Auth%20Screens/auth_bloc/auth_bloc.dart';
import 'package:onze_cafe/screens/Home%20Screen/home_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  final String password;
  final String name;
  final String phone;
  const OtpScreen(
      {super.key,
      required this.email,
      required this.password,
      required this.name,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 12.w,
      height: 7.h,
      textStyle: TextStyle(
        color: const Color(0xffD7D1CA),
        fontSize: 3.h,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffD7D1CA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xff57E3D8)),
      ),
    );

    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AuthBloc>();
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SuccessfulVerifyState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              }
              if (state is ErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }

              if(state is SuccessfulResentOTPState){
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('OTP Resent')));
              }
            },
            child: Scaffold(
              extendBodyBehindAppBar: true,
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/Home.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 150,
                            ),
                            Text(
                              'Enter the OTP sent to your Email',
                              style: TextStyle(
                                fontSize: 2.5.h,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffD7D1CA),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'We have sent the OTP code to',
                              style: TextStyle(
                                fontSize: 1.6.h,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffD7D1CA),
                              ),
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 1.6.h,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff87B1C5),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Center(
                                child: Pinput(
                                  length: 6,
                                  defaultPinTheme: defaultPinTheme,
                                  submittedPinTheme: submittedPinTheme,
                                  showCursor: true,
                                  onCompleted: (pin) {
                                    bloc.add(VerifyEvent(
                                        email: email,
                                        password: password,
                                        otp: pin,
                                        name: name,
                                        phone: phone));
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            GestureDetector(
                              onTap: () {
                                bloc.add(ResendOtpEvent(email: email));
                              },
                              child: Text(
                                'Resend OTP',
                                style: TextStyle(
                                  fontSize: 2.h,
                                  fontStyle: FontStyle.italic,
                                  color: const Color(0xff87B1C5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
