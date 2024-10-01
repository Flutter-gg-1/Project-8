import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../managers/auth_session/auth_mgr.dart';

class DIContainer {
  static Future<void> storageSetup() async {
    await GetStorage.init();
    GetIt.I.registerSingleton<AuthMgr>(AuthMgr());
  }

  static configureOneSignal() {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize('9ef08024-c628-4bca-a101-1a15e7ee892c');
    OneSignal.Notifications.requestPermission(true);
  }
}
