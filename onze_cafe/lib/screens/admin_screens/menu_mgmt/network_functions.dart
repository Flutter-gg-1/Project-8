import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/menu_mgmt_cubit.dart';
import 'package:onze_cafe/supabase/supabase_menu.dart';

import '../../../supabase/supabase_category.dart';

extension NetworkFunctions on MenuMgmtCubit {
  Future fetchCategories(BuildContext context) async {
    try {
      final response = await SupabaseCategory.fetchCategories();
      if (context.mounted) {
        showSnackBar(context, 'Categories finished loading',
            AnimatedSnackBarType.success);
      }
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
      if (context.mounted) {
        showSnackBar(context, 'Menu Items finished loading',
            AnimatedSnackBarType.success);
      }
      return response;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }
}
