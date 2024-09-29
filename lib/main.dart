import 'package:flutter/material.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/screens/Auth%20Screens/first_screen.dart';
import 'package:onze_cafe/screens/Employee%20Screen/employee_screen.dart';
import 'package:onze_cafe/screens/Home%20Screen/home_screen.dart';
import 'package:onze_cafe/services/db_operations.dart';
import 'package:onze_cafe/services/setup.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  login(email: 'aazizalamri2@gmail.com', password: '123123');
  // locator.get<DataLayer>().getUserById(email: 'aazizalamri2@gmail.com');
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
          debugShowCheckedModeBanner: false, home: EmployeeScreen());
    });
  }
}
