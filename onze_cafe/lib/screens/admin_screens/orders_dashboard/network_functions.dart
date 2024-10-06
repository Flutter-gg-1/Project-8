import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/managers/notifications_mgr.dart';
import 'package:onze_cafe/model/order.dart';
import 'package:onze_cafe/screens/admin_screens/orders_dashboard/orders_dashboard_cubit.dart';
import 'package:onze_cafe/supabase/supabase_cart.dart';
import 'package:onze_cafe/supabase/supabase_profile.dart';

import '../../../model/enums/order_status.dart';
import '../../../supabase/supabase_menu.dart';
import '../../../supabase/supabase_order.dart';

extension NetworkFunctions on OrdersDashboardCubit {
  Future fetchMenuItems(BuildContext context) async {
    emitLoading();
    try {
      final response = await SupabaseMenu.fetchMenuItems();
      emitUpdate();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }

  Future fetchOrders(BuildContext context) async {
    emitLoading();
    try {
      final response = await SupabaseOrder.fetchPlacedOrders();
      emitUpdate();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }

  Future updateOrder(
      BuildContext context, Order orderItem, OrderStatus status) async {
    emitLoading();
    orderItem.status = status.name();
    try {
      var profile = await SupabaseProfile.fetchProfile(orderItem.userId);

      final response =
          await SupabaseOrder.updateOrder(placedOrderItem: orderItem);
      await NotificationsMgr.sendNotificationToUser(
          profile?.externalId ?? '', status.name());
      emitUpdate();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }

  Future fetchOrderItems(BuildContext context, Order orderItem) async {
    emitLoading();
    try {
      final response = await SupabaseCart.fetchOrderItems(orderItem.id ?? '');
      emitUpdate();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }
}
