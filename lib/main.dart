import 'package:flutter/material.dart';
import 'package:onze_cafe/Auth%20Screens/first_screen.dart';
import 'package:onze_cafe/Auth%20Screens/login_screen.dart';
import 'package:onze_cafe/Auth%20Screens/otp_screen.dart';
import 'package:onze_cafe/Auth%20Screens/register_screen.dart';
import 'package:onze_cafe/Bottom_Nav/bottom_nav.dart';
import 'package:onze_cafe/Home%20Screen/home_screen.dart';
import 'package:onze_cafe/Order%20Screen/order_screen.dart';
import 'package:onze_cafe/services/db_operations.dart';
import 'package:onze_cafe/services/setup.dart';
import 'package:onze_cafe/test_payment/orders_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  // await supabase.auth.signUp(
  //       email: 'aazizalamri2@gmail.com', password: '123123');
  // await supabase.auth
  //     .verifyOTP(
  //       type: OtpType.signup,
  //       email: 'aazizalamri2@gmail.com', token: '727917');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const MaterialApp(
          debugShowCheckedModeBanner: false, home: RegisterScreen());
    });
  }
}
