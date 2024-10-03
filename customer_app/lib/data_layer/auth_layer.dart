import 'package:customer_app/models/user_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AuthLayer {
  final box = GetStorage();
  UserModel? user = UserModel(
      customerId: "929fc748-4578-414d-bc33-06bdbaad123a",
      email: "email",
      firstName: "firstName",
      lastName: "lastName");
  AuthLayer() {
    loadDataAuth();
  }

  Future<void> saveAuth({required UserModel userData}) async {
    OneSignal.login(userData.customerId);
    user = userData;
    await box.write("user", userData.toJson());
  }

  Future<void> loadDataAuth() async {
    if (box.hasData('user')) {
      user = UserModel.fromJson(
          Map.from(await box.read("user")).cast<String, dynamic>());
    }
  }

  Future<void> logOut() async {
    box.erase();
    user = null;
  }

  
}
