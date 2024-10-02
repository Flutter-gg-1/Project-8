import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onze_cafe/screens/landing/landing_screen.dart';

import '../managers/auth_session/auth_mgr.dart';

class DIContainer {
  static Future<void> storageSetup() async {
    await GetStorage.init();
    GetIt.I.registerSingleton<AuthMgr>(AuthMgr());
  }

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

      var data = event.notification.additionalData;
      if (data != null) {
        String? page = data['page'];
        String? landing = data['landing'];
        if (page != null || landing != null) {
          if (navKey.currentState != null) {
            navKey.currentState!
                .push(MaterialPageRoute(builder: (context) => LandingScreen()));
          }
        }
      }
      event.notification.display();
    });
  }
}
