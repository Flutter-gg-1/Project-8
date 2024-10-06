import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onze_cafe/screens/admin_screens/orders_dashboard/orders_dashboard_screen.dart';
import 'package:onze_cafe/screens/order/orders_screen.dart';
import 'package:onze_cafe/supabase/client/supabase_mgr.dart';

class DIContainer {
  static configureOneSignal() async {
    await dotenv.load(fileName: ".env");
    OneSignal.Debug.setLogLevel(OSLogLevel.error);
    OneSignal.initialize(dotenv.env['OneSignal_KEY']!);
    OneSignal.Notifications.requestPermission(true);
  }

  static handleNotifications(
      BuildContext context, GlobalKey<NavigatorState> navKey) {
    OneSignal.Notifications.addClickListener((event) async {
      event.preventDefault();

      await SupabaseMgr.shared.setCurrentUser();

      if (SupabaseMgr.shared.currentProfile != null) {
        if (SupabaseMgr.shared.currentProfile!.role == 'customer') {
          if (navKey.currentState != null) {
            navKey.currentState!
                .push(MaterialPageRoute(builder: (context) => OrdersScreen()));
          }
        } else if (SupabaseMgr.shared.currentProfile!.role == 'employee') {
          if (navKey.currentState != null) {
            navKey.currentState!.push(MaterialPageRoute(
                builder: (context) => OrdersDashboardScreen()));
          }
        }
      }
      event.notification.display();
    });
  }
}
