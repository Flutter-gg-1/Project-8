import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        // verify otp <bloc> <cubit>
                      },
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                GestureDetector(
                  onTap: () {
                    // Resend OTP ??
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
    );
  }
}
