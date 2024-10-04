import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_offer/add_offer_cubit.dart';

import '../../../../model/offer.dart';
import '../../../../supabase/supabase_offer.dart';

extension NetworkFunctions on AddOfferCubit {
  Future upsertOffer(BuildContext context) async {
    emitLoading();
    try {
      final price = double.parse(priceController.text);
      var offer = Offer(
          menuItemId: selectedMenuItem?.id ?? '',
          price: price,
          startDate: startDate.toIso8601String(),
          endDate: endDate.toIso8601String());

      await SupabaseOffer.upsertOffer(offer: offer);
      emitUpdate();
      if (context.mounted) Navigator.pop(context, true);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }
}
