import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:onze_cafe/models/user_model.dart';
import 'package:onze_cafe/services/db_operations.dart';

class DataLayer {
  String? token;
  UserModel? user;
  final box = GetStorage();

  DataLayer() {
    loadData();
  }

  saveAuth({required String token, required Map<String, dynamic> user}) async {
    await box.write('auth', token);
    await box.write('user', user);
  }

  loggedIn() {
    if (box.hasData('auth')) {
      return true;
    }
    return false;
  }

  logout() async {
    box.erase();
    token = null;
    user = null;
  }

  loadData() {
    if (box.hasData('auth')) {
      token = box.read('auth');
    }

    if (box.hasData('user')) {
      user = UserModel.fromJson(Map<String, dynamic>.from(box.read('user')));
    }
  }

  Future<Map<String, dynamic>> getUserById({required String email}) async {
    final response =
        await supabase.from('app_user').select().eq('email', email).single();

    return response;
  }
}
