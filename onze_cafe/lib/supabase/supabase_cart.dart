import 'package:onze_cafe/model/cart_Item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'client/supabase_mgr.dart';

class SupabaseCart {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'cart_item';

  static Future<List<CartItem>>? fetchCart() async {
    try {
      var res = await supabase.from(tableKey).select();
      List<CartItem> categories = (res as List)
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
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
    var response = await supabase.from(tableKey).select().single();
    print(response);
  }

  static Future upsertCartItem({required CartItem cartItem}) async {
    try {
      var response = await supabase.from(tableKey).upsert(
            cartItem.toJson(),
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

  static Future deleteCartItem(CartItem cartItem) async {
    if (cartItem.id == null) {
      throw Exception('Could not find records of this category');
    }
    try {
      await supabase.from(tableKey).delete().eq('id', cartItem.id!);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
