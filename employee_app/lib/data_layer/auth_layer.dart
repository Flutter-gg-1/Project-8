import 'package:employee_app/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

class AuthLayer {
  final box = GetStorage();
  UserModel? user;
  AuthLayer() {
    loadDataAuth();
  }

  Future<void> saveAuth({required UserModel userData}) async {
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

  userGiveVal({required UserModel userModel}) {
    user = userModel;
  }
}
