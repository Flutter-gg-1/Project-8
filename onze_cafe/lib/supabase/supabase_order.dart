import 'package:onze_cafe/model/order.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'client/supabase_mgr.dart';

class SupabaseOrder {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'placed_order';

  static Future<List<Order>>? fetchUserOrders() async {
    try {
      var res = await supabase
          .from(tableKey)
          .select()
          .eq('user_id', SupabaseMgr.shared.currentUser?.id ?? '')
          .limit(50);
      List<Order> orders = (res as List)
          .map((item) => Order.fromJson(item as Map<String, dynamic>))
          .toList();
      return orders;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Order>>? fetchPlacedOrders() async {
    try {
      var res = await supabase.from(tableKey).select().limit(50);
      List<Order> orders = (res as List)
          .map((item) => Order.fromJson(item as Map<String, dynamic>))
          .toList();
      return orders;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Order> insertOrder({required Order placedOrderItem}) async {
    try {
      final response = await supabase
          .from(tableKey)
          .insert(placedOrderItem.toJson())
          .select()
          .single();

      return Order.fromJson(response);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future updateOrder({required Order placedOrderItem}) async {
    try {
      await supabase
          .from(tableKey)
          .update(placedOrderItem.toJson())
          .eq('id', placedOrderItem.id ?? '');
      return placedOrderItem;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future deletePlacedOrder(Order placedOrderItem) async {
    if (placedOrderItem.id == null) {
      throw Exception('Could not find records of this placedOrderItem');
    }
    try {
      await supabase.from(tableKey).delete().eq('id', placedOrderItem.id!);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
