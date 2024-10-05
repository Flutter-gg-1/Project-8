import 'package:onze_cafe/model/placed_order.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'client/supabase_mgr.dart';

class SupabasePOrder {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'placed_order';

  static Future<List<PlacedOrder>>? fetchUserOrders() async {
    try {
      var res = await supabase
          .from(tableKey)
          .select()
          .eq('user_id', SupabaseMgr.shared.currentUser?.id ?? '')
          .limit(50);
      List<PlacedOrder> orders = (res as List)
          .map((item) => PlacedOrder.fromJson(item as Map<String, dynamic>))
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

  static Future<List<PlacedOrder>>? fetchPlacedOrders() async {
    try {
      var res = await supabase.from(tableKey).select().limit(50);
      List<PlacedOrder> orders = (res as List)
          .map((item) => PlacedOrder.fromJson(item as Map<String, dynamic>))
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

  static Future upsertPlacedOrder(
      {required PlacedOrder placedOrderItem}) async {
    try {
      await supabase.from(tableKey).upsert(placedOrderItem.toJson());
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future deletePlacedOrder(PlacedOrder placedOrderItem) async {
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
