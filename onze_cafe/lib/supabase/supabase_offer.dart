import 'package:onze_cafe/model/offer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'client/supabase_mgr.dart';

class SupabaseOffer {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'offer';

  static Future<List<Offer>>? fetchOffer() async {
    try {
      var res = await supabase.from(tableKey).select();
      List<Offer> categories = (res as List)
          .map((item) => Offer.fromJson(item as Map<String, dynamic>))
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

  static Future upsertOfferItem({required Offer offerItem}) async {
    try {
      var response = await supabase.from(tableKey).upsert(
            offerItem.toJson(),
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

  static Future deleteOfferItem(Offer offerItem) async {
    if (offerItem.id == null) {
      throw Exception('Could not find records of this Offer');
    }
    try {
      await supabase.from(tableKey).delete().eq('id', offerItem.id!);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

}
