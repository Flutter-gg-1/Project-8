import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/supabase/supabase_cart.dart';
import 'package:onze_cafe/supabase/supabase_menu.dart';

import '../../supabase/supabase_category.dart';
import '../../supabase/supabase_offer.dart';
import 'menu_cubit.dart';

extension NetworkFunctions on MenuCubit {
  // Categories
  Future fetchCategories(BuildContext context) async {
    emitLoading();
    try {
      emitLoading();
      final response = await SupabaseCategory.fetchCategories();

      if (context.mounted) {
        showSnackBar(context, 'Categories finished loading',
            AnimatedSnackBarType.success);
      }
      emitUpdate();
      return response;
    } catch (e) {
      emitUpdate();
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
      emitLoading();
      final response = await SupabaseMenu.fetchMenuItems();
      emitUpdate();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Menu Items finished loading',
            AnimatedSnackBarType.success);
      }
      emitUpdate();
    }
  }

  // Offers

  Future fetchOffers(BuildContext context) async {
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

  // Cart
  Future fetchCart(BuildContext context) async {
    emitLoading();
    try {
      final response = await SupabaseCart.fetchCart();
      emitUpdate();
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
      emitUpdate();
    }
  }
}
