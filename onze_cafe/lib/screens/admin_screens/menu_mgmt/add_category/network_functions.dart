import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_category/add_category_cubit.dart';
import 'package:onze_cafe/supabase/supabase_category.dart';

extension NetworkFunctions on AddCategoryCubit {
  Future upsertCategory(BuildContext context) async {
    emitLoading();
    try {
      await SupabaseCategory.upsertCategory(
          category: MenuCategory(
            name: nameController.text,
            description: descriptionController.text,
            imgUrl: '',
            sortPriority: sortPriority,
          ),
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
