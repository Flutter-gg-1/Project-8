import 'package:onze_cafe/model/cart_Item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'client/supabase_mgr.dart';

class SupabaseCart {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'cart_item';

  static Future<List<CartItem>> fetchCart() async {
    var currentUserId = SupabaseMgr.shared.currentUser?.id ?? '';

    try {
      var res =
          await supabase.from(tableKey).select().eq('user_id', currentUserId);

      List<CartItem> cartItems = (res as List)
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList();

      return cartItems;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future insertCartItem({required CartItem cartItem}) async {
    try {
      await supabase.from(tableKey).insert(cartItem.toJson());
      return cartItem;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future updateCartItem({required CartItem cartItem}) async {
    try {
      await supabase
          .from(tableKey)
          .update(cartItem.toJson())
          .eq('id', cartItem.id ?? '');
      return cartItem;
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
      throw Exception('Could not find records of this cartItem');
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
