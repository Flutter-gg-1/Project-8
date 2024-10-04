import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/menu_mgmt_cubit.dart';
import 'package:onze_cafe/supabase/supabase_menu.dart';
import 'package:onze_cafe/supabase/supabase_offer.dart';

import '../../../model/menu_item.dart';
import '../../../model/offer.dart';
import '../../../supabase/supabase_category.dart';

extension NetworkFunctions on MenuMgmtCubit {
  // Categories
  Future fetchCategories(BuildContext context) async {
    emitLoading();
    try {
      final response = await SupabaseCategory.fetchCategories();
      emitUpdate();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }

  Future deleteCategory(BuildContext context, MenuCategory category) async {
    emitLoading();
    try {
      await SupabaseCategory.deleteCategory(category);
      categories = await SupabaseCategory.fetchCategories() ?? [];
      emitUpdate();
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }

  // Menu Items
  Future fetchMenuItems(BuildContext context) async {
    emitLoading();
    try {
      final response = await SupabaseMenu.fetchMenuItems();
      emitUpdate();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }

  Future deleteMenuItem(BuildContext context, MenuItem item) async {
    emitLoading();
    try {
      await SupabaseMenu.deleteItem(item);
      items = await SupabaseMenu.fetchMenuItems() ?? [];
      emitUpdate();
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }

  // Offers

  Future fetchMenuOffers(BuildContext context) async {
    emitLoading();
    try {
      final response = await SupabaseOffer.fetchOffers();
      emitUpdate();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }

  Future deleteOffer(BuildContext context, Offer offer) async {
    emitLoading();
    try {
      await SupabaseOffer.deleteOffer(offer);
      offers = await SupabaseOffer.fetchOffers() ?? [];
      emitUpdate();
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }
}
