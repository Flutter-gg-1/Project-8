import 'package:customer_app/DB/super_main.dart';
import 'package:customer_app/models/order_details_model.dart';
import 'package:customer_app/models/order_model.dart';
import 'package:customer_app/models/user_model.dart';
import 'package:customer_app/screens/auth/login_screen.dart';
import 'package:customer_app/screens/auth/signup_screen.dart';
import 'package:customer_app/screens/first_screen.dart';
import 'package:customer_app/screens/order_history/history_screen.dart';
import 'package:customer_app/screens/home_screen.dart';
import 'package:customer_app/screens/order/order_status.dart';
import 'package:customer_app/services/setup.dart';
import 'package:flutter/material.dart';
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


  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize(dotenv.env["onesignal_app_key"]!);

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xffD7D1CA),
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xffD7D1CA))),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(
          user: UserModel(
              customerId: '',
              email: 'email',
              firstName: 'Basel',
              lastName: 'Alalawi'),
        )
        // OrderStatus(order: OrderModel(
        //   orderId: '062a8cfc-deb9-4cd6-9c00-e7af246cfce3',
        //   time: DateTime.now(),
        //   totalPreparationTime: 12,
        //   totalPrice: 120

        // ),),

        );
  }
}
