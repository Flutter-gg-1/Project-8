import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/supabase/supabase_menu.dart';

import '../../supabase/supabase_category.dart';
import 'menu_cubit.dart';

extension NetworkFunctions on MenuCubit {
  Future fetchCategories(BuildContext context) async {
    try {
      emitLoading();
      final response = await SupabaseCategory.fetchCategories();
      if (context.mounted) {
        showSnackBar(context, 'Categories finished loading',
            AnimatedSnackBarType.success);
      }
      await Future.delayed(Duration(seconds: 1));
      emitUpdate();
      return response;
    } catch (e) {
      emitUpdate();
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }

  Future fetchMenuItems(BuildContext context) async {
    //
    try {
      emitLoading();
      final response = await SupabaseMenu.fetchMenuItems();
      if (context.mounted) {
        showSnackBar(context, 'Menu Items finished loading',
            AnimatedSnackBarType.success);
      }

      emitUpdate();
      return response;
    } catch (e) {
      emitUpdate();
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }
}
