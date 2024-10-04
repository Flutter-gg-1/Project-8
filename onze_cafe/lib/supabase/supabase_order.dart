import 'package:onze_cafe/model/placed_order.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'client/supabase_mgr.dart';

class SupabasePOrder {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'placed_order';

  static Future<List<PlacedOrder>>? fetchPlacedOrder() async {
    try {
      var res = await supabase.from(tableKey).select();
      List<PlacedOrder> categories = (res as List)
          .map((item) => PlacedOrder.fromJson(item as Map<String, dynamic>))
          .toList();
      return categories;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> readData() async {
    var response = await supabase.from(tableKey).select();
    print(response);
  }

  static Future upsertPlacedOrder(
      {required PlacedOrder placedOrderItem}) async {
    try {
      var response = await supabase.from(tableKey).upsert(
            placedOrderItem.toJson(),
          );

      return print(response);
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
