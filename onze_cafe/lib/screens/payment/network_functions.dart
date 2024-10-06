import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/model/enums/order_status.dart';
import 'package:onze_cafe/model/order.dart';
import 'package:onze_cafe/screens/payment/payment_cubit.dart';
import 'package:onze_cafe/supabase/client/supabase_mgr.dart';
import 'package:onze_cafe/supabase/supabase_cart.dart';
import 'package:onze_cafe/supabase/supabase_order.dart';

import '../../managers/notifications_mgr.dart';

extension NetworkFunctions on PaymentCubit {
  // Fetch Cart

  Future fetchCart(BuildContext context) async {
    emitLoading();
    try {
      final response = await SupabaseCart.fetchCart();
      emitUpdate();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }

  // Create Order

  Future createOrder(BuildContext context) async {
    emitLoading();
    var order = Order(
      userId: SupabaseMgr.shared.currentUser?.id ?? '',
      status: OrderStatus.placed.name(),
      price: (totalPrice / 100).toDouble(),
      isPayed: true,
    );

    try {
      final response = await SupabaseOrder.insertOrder(placedOrderItem: order);

      if (context.mounted) await updateCartItems(context, response.id ?? '');

      NotificationsMgr.sendNotification(
          msg: 'New Order Placed', segment: NotificationSegment.employee);

      emitUpdate();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }

  // Update Cart

  Future updateCartItems(BuildContext context, String orderId) async {
    emitLoading();

    for (var cartItem in cartItems) {
      cartItem.placedOrderId = orderId;
      try {
        await SupabaseCart.updateCartItem(cartItem: cartItem);
      } catch (e) {
        if (context.mounted) {
          showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
        }
        emitUpdate();
      }
    }
  }
}
