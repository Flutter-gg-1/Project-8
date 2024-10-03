import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_menu_item/add_menu_item_cubit.dart';
import 'package:onze_cafe/supabase/supabase_menu.dart';

extension NetworkFunctions on AddMenuItemCubit {
  Future upsertMenuItem(BuildContext context) async {
    emitLoading();
    try {
      if (selectedCategory == null) {
        throw Exception('No Selected Category!');
      }

      final int calories = int.parse(caloriesController.text);
      final double price = double.parse(priceController.text);
      final double oz = double.parse(ozController.text);

      await SupabaseMenu.upsertItem(
          item: MenuItem(
              categoryId: selectedCategory?.id ?? '',
              name: nameController.text,
              calories: calories,
              price: price,
              oz: oz),
          imageFile: imgFile);
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
