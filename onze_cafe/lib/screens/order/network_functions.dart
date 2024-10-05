import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:onze_cafe/screens/order/order_cubit.dart';

import '../../supabase/supabase_order.dart';

extension NetworkFunctions on OrderCubit {
  Future fetchUserOrders(BuildContext context) async {
    emitLoading();
    try {
      final response = await SupabaseOrder.fetchUserOrders();
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
