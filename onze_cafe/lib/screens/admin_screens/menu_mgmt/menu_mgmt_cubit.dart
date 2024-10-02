import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/screens/admin_screens/add_category/add_category_screen.dart';
import 'package:onze_cafe/screens/admin_screens/add_menu_item_screen.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/network_functions.dart';

import '../../../model/menu_item.dart';
import '../../../reusable_components/animated_snackbar.dart';

part 'menu_mgmt_state.dart';

class MenuMgmtCubit extends Cubit<MenuMgmtState> {
  MenuMgmtCubit(BuildContext context) : super(MenuMgmtInitial()) {
    fetchCategories(context);
  }
  List<MenuCategory> categories = [];
  List<MenuItem> items = [];

  navigateToAddCat(BuildContext context, MenuCategory? cat) =>
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => AddCategoryScreen(category: cat)))
          .then((_) {
        if (context.mounted) loadInitialValues(context);
      });

  navigateToAddMenuItem(BuildContext context) => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AddMenuItemScreen()))
          .then((_) {
        if (context.mounted) loadInitialValues(context);
      });

  loadInitialValues(BuildContext context) async {
    categories = await fetchCategories(context);
    await Future.delayed(Duration(milliseconds: 50));
    emit(UpdateUIState());
  }

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }
}
