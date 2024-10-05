import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/screens/landing/landing_screen.dart';
import 'package:onze_cafe/screens/order/orders_screen.dart';
import 'package:onze_cafe/screens/order_details/order_details_screen.dart';
import 'package:onze_cafe/screens/payment/payment_screen.dart';
import 'package:onze_cafe/services/di_container.dart';
import 'package:onze_cafe/supabase/client/supabase_mgr.dart';

import 'app_theme/app_theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseMgr.shared.initialize();
  await DIContainer.storageSetup();
  DIContainer.configureOneSignal();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MainApp());
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var navKey = GlobalKey<NavigatorState>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      DIContainer.handleNotifications(context, navKey);
    });

    return BlocProvider(
      create: (context) => AppThemeCubit()..changeTheme(ThemeMode.system),
      child: BlocBuilder<AppThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            navigatorKey: navKey, // Assign navigatorKey to the MaterialApp
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeMode,
            home: OrderDetailsScreen(
                orderId: 'e9ea3587-0c68-47a0-a795-3ef3974c3e75', price: 14.0),
          );
        },
      ),
    );
  }
}
