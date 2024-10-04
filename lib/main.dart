import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onze_cafe/screens/Auth%20Screens/first_screen.dart';
import 'package:onze_cafe/services/setup.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  //  await login(email: 'aazizalamri2@gmail.com', password: '123123');
  // await fetchAllOrders();

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('${dotenv.env['onesignal_key']}');
  OneSignal.Notifications.requestPermission(true);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const MaterialApp(
          debugShowCheckedModeBanner: false, home: FirstScreen());
    });
  }
}
