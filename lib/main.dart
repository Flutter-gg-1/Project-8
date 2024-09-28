import 'package:flutter/material.dart';
import 'package:onze_cafe/Auth%20Screens/first_screen.dart';
import 'package:onze_cafe/Auth%20Screens/login_screen.dart';
import 'package:onze_cafe/Auth%20Screens/otp_screen.dart';
import 'package:onze_cafe/Auth%20Screens/register_screen.dart';
import 'package:onze_cafe/Bottom_Nav/bottom_nav.dart';
import 'package:onze_cafe/Home%20Screen/home_screen.dart';
import 'package:onze_cafe/services/setup.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const MaterialApp(
          debugShowCheckedModeBanner: false, home: HomeScreen());
    });
  }
}
