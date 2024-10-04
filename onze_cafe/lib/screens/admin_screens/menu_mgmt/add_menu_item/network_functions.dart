import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_menu_item/add_menu_item_cubit.dart';
import 'package:onze_cafe/supabase/supabase_menu.dart';

extension NetworkFunctions on AddMenuItemCubit {
  Future upsertMenuItem(BuildContext context) async {
    emitLoading();
    try {
      if (selectedCategory == null) {
        throw Exception('No Selected Category!');
      }

      updateMenuItem();

      await SupabaseMenu.upsertItem(item: menuItem, imageFile: imgFile);
      emitUpdate();
      if (context.mounted) Navigator.pop(context, true);
    } catch (e) {
      emitUpdate();
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }
}
