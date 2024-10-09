
import 'package:customer_app/DB/super_main.dart';
import 'package:customer_app/data_layer/auth_layer.dart';
import 'package:customer_app/models/order_details_model.dart';
import 'package:customer_app/models/order_model.dart';
import 'package:customer_app/models/user_model.dart';
import 'package:customer_app/screens/auth/login_screen.dart';
import 'package:customer_app/screens/auth/signup_screen.dart';
import 'package:customer_app/screens/first_screen.dart';
import 'package:customer_app/screens/order_history/history_screen.dart';
import 'package:customer_app/screens/home/home_screen.dart';
import 'package:customer_app/screens/order/order_status.dart';
import 'package:customer_app/services/setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  await setup();
  final test = SuperMain();

  await test.getMenu();

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize(dotenv.env["onesignal_app_key"]!);

  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xffD7D1CA),
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xffD7D1CA))),
        debugShowCheckedModeBanner: false,
        home: FirstScreen());
  }
}