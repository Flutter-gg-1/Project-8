import 'dart:developer';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/order_item_model.dart';
import 'package:onze_cafe/services/notification.dart';
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

Future resendOtp({required String email}) async {
  try {
    final authRes = await supabase.auth.resend(
      type: OtpType.signup,
      email: email,
    );

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
    OneSignal.login(locator.get<DataLayer>().externalKey!);
    await supabase
        .from('app_user')
        .update({'external_key': locator.get<DataLayer>().externalKey}).eq(
            'user_id', user['user_id']);
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

Future addItem({required OrderItemModel item}) async {
  try {
    final orderStatus = await supabase
        .from('orders')
        .select('*')
        .eq('order_id', locator.get<DataLayer>().order!.orderId)
        .eq('status', 'complete')
        .maybeSingle();

    if (orderStatus != null) {
      await supabase.from('orders').update({'status': 'incomplete'}).eq(
          'order_id', locator.get<DataLayer>().order!.orderId);
    }

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

saveOrder({required double totalPrice, required int orderId}) async {
  for (var item in locator.get<DataLayer>().cart.items) {
    addItem(item: item);
  }
  await supabase
      .from('orders')
      .update({'total_price': totalPrice})
      .eq('order_id', orderId);
}

Future<List<Map<String, dynamic>>> fetchAllOrders() async {
  final response = await supabase
      .from('order_item')
      .select('*, orders(*), item(*)')
      .eq('item_status', 'incomplete');

  await Future.delayed(const Duration(seconds: 1));

  return response;
}

getCustomerName({required String userId}) async {
  final name =
      await supabase.from('app_user').select('name').eq('user_id', userId);
  return name;
}

Future<void> markItemAsComplete(
    {required int orderId, required int itemId}) async {
  try {
    // make order_item status complete
    await supabase
        .from('order_item')
        .update({'item_status': 'complete'})
        .eq('order_id', orderId)
        .eq('item_id', itemId);

    // make order status complete if all items are complete
    final items = await supabase
        .from('order_item')
        .select('item_status')
        .eq('order_id', orderId);

    bool allItemsComplete =
        items.every((item) => item['item_status'] == 'complete');
    if (allItemsComplete) {
      await supabase
          .from('orders')
          .update({'status': 'complete'}).eq('order_id', orderId);

      // Get user_id
      final order = await supabase
          .from('orders')
          .select('user_id')
          .eq('order_id', orderId)
          .single();

      //  fetch external_key
      final externalKeyResponse = await supabase
          .from('app_user')
          .select('external_key')
          .eq('user_id', order['user_id'])
          .single();

      final String externalKey = externalKeyResponse['external_key'].toString();

      // Notify user
      sendNotification(externalKey: externalKey);

      await supabase.from('order_item').delete().eq('order_id', orderId);
    }
  } catch (error) {
    log('Error marking item as ready: $error');
    return Future.error(error);
  }
}

Future<void> cancelOrderItem(
    {required int orderId, required int itemId}) async {
  try {
    await supabase
        .from('order_item')
        .delete()
        .eq('item_id', itemId)
        .eq('order_id', orderId);

    // make order status complete if all items are complete
    final items = await supabase
        .from('order_item')
        .select('item_status')
        .eq('order_id', orderId);

    bool allItemsComplete =
        items.every((item) => item['item_status'] == 'complete');
    if (allItemsComplete) {
      await supabase
          .from('orders')
          .update({'status': 'complete'}).eq('order_id', orderId);

      await supabase.from('order_item').delete().eq('order_id', orderId);
    }
  } catch (error) {
    log('Error Cancelling item: $error');
    return Future.error(error);
  }
}
