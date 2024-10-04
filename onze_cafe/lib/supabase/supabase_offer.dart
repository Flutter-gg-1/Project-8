import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/offer.dart';
import 'client/supabase_mgr.dart';

class SupabaseOffer {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'offer';

  static Future<List<Offer>>? fetchOffers() async {
    try {
      var res = await supabase.from(tableKey).select();
      List<Offer> offers = (res as List)
          .map((item) => Offer.fromJson(item as Map<String, dynamic>))
          .toList();
      return offers;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future upsertOffer({required Offer offer}) async {
    try {
      var response = await supabase.from(tableKey).upsert(
            offer.toJson(),
            onConflict: 'menu_item_id',
          );
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future deleteOffer(Offer offer) async {
    if (offer.id == null) {
      throw Exception('Could not find records of this offer');
    }
    try {
      await supabase.from(tableKey).delete().eq('id', offer.id!);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
