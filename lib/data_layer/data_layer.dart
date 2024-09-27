import 'package:get_storage/get_storage.dart';

class DataLayer {
  String? token;
  final box = GetStorage();

  DataLayer() {
    // loadData();
  }

  saveAuth({required String token}) async {
    await box.write('auth', token);
  }

  loggedIn() {
    if (box.hasData('auth')) {
      return true;
    }
    return false;
  }

  loggedOut() async {
    box.erase();
    token = null;
  }

  loadData() {
    if (box.hasData('auth')) {
      token = box.read('auth');
    }
  }
}
