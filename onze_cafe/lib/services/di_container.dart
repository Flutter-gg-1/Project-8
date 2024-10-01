import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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
}
