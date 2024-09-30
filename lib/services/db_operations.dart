import 'dart:developer';

import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/models/order_item_model.dart';
import 'package:onze_cafe/services/setup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future createAccount({required String email, required String password}) async {
  try {
    final AuthResponse authRes =
        await supabase.auth.signUp(email: email, password: password);

    return authRes;
  } catch (error) {
    return Future.error(error);
  }
}

Future login({required String email, required String password}) async {
  try {
    final authRes = await supabase.auth
        .signInWithPassword(email: email, password: password);
    Map<String, dynamic> user =
        await locator.get<DataLayer>().getUserByEmail(email: email);
    await locator
        .get<DataLayer>()
        .saveAuth(token: authRes.session!.accessToken, user: user);
    return authRes;
  } catch (error) {
    return Future.error(error);
  }
}

Future verify(
    {required String email,
    required String otp,
    required String name,
    required String phone}) async {
  try {
    final authRes = await supabase.auth
        .verifyOTP(type: OtpType.signup, email: email, token: otp);

    await supabase.from('app_user').insert({
      'user_id': authRes.user?.id,
      'name': name,
      'email': email,
      'phone': phone,
    });
    return authRes;
  } catch (error) {
    return Future.error(error);
  }
}

Future createOrder(
    {required String status,
    required String placedAt,
    required String readyAt,
    required double totalPrice}) async {
  try {
    await supabase.from('orders').insert({
      'user_id': supabase.auth.currentUser?.id,
      'status': status,
      'placed_at': DateTime.parse(placedAt),
      'ready_at': DateTime.parse(readyAt),
      'total_price': totalPrice,
    });
  } catch (error) {
    return Future.error(error);
  }
}

Future addItem(
    // pass OrderItemModel
    {required OrderItemModel item}) async {
  try {
    await supabase.from('order_item').insert({
      'item_id': item.itemId,
      'order_id': item.orderId,
      'quantity': item.quantity,
      'price': item.price,
    });
  } catch (error) {
    return Future.error(error);
  }
}

saveOrder() async {
  for (var item in locator.get<DataLayer>().cart.items) {
    addItem(item: item);
  }
  
}
