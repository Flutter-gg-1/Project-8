import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/menu_mgmt_cubit.dart';
import 'package:onze_cafe/supabase/supabase_menu.dart';
import 'package:onze_cafe/supabase/supabase_offer.dart';

import '../../../supabase/supabase_category.dart';

extension NetworkFunctions on MenuMgmtCubit {
  Future fetchCategories(BuildContext context) async {
    try {
      final response = await SupabaseCategory.fetchCategories();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }

  Future fetchMenuItems(BuildContext context) async {
    try {
      final response = await SupabaseMenu.fetchMenuItems();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }

  Future fetchMenuOffers(BuildContext context) async {
    try {
      final response = await SupabaseOffer.fetchOffers();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }
}
