import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/screens/admin_screens/add_category/add_category_cubit.dart';
import 'package:onze_cafe/supabase/supabase_category.dart';

extension NetworkFunctions on AddCategoryCubit {
  Future upsertCategory(BuildContext context) async {
    try {
      await SupabaseCategory.upsertCategory(
          category: MenuCategory(
            name: nameController.text,
            description: descriptionController.text,
            imgUrl: '',
            sortPriority: sortPriority,
          ),
          imageFile: imgFile);
      if (context.mounted) {
        showSnackBar(
            context, 'Completed Successfully', AnimatedSnackBarType.success);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }
}
