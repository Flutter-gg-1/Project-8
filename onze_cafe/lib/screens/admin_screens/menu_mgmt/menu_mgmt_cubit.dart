import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_category/add_category_screen.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/network_functions.dart';

import '../../../model/menu_item.dart';
import '../../../model/offer.dart';
import '../../../reusable_components/animated_snackbar.dart';
import 'add_menu_item/add_menu_item_screen.dart';
import 'add_offer/add_offer_screen.dart';

part 'menu_mgmt_state.dart';

class MenuMgmtCubit extends Cubit<MenuMgmtState> {
  MenuMgmtCubit(BuildContext context) : super(MenuMgmtInitial()) {
    loadInitialValues(context);
  }
  List<MenuCategory> categories = [];
  List<MenuItem> items = [];
  List<Offer> offers = [];

  loadInitialValues(BuildContext context) async {
    emit(LoadingState());
    categories = await fetchCategories(context);
    if (context.mounted) items = await fetchMenuItems(context);
    if (context.mounted) offers = await fetchMenuOffers(context);
    await Future.delayed(Duration(milliseconds: 50));
    emit(UpdateUIState());
  }

  navigateToAddCat(BuildContext context, MenuCategory? cat) =>
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => AddCategoryScreen(category: cat)))
          .then((categoryAdded) {
        if (context.mounted && categoryAdded == true) {
          showSnackBar(context, 'Category Added', AnimatedSnackBarType.success);
          loadInitialValues(context);
        }
      });

  navigateToAddMenuItem(BuildContext context, MenuItem? item) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) =>
                AddMenuItemScreen(item: item, categories: categories)))
        .then((itemAdded) {
      if (context.mounted && itemAdded == true) {
        showSnackBar(context, 'Item Added', AnimatedSnackBarType.success);
        loadInitialValues(context);
      }
    });
  }

  navigateToAddOffer(BuildContext context, Offer? offer) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) =>
                AddOfferScreen(offer: offer, menuItems: items)))
        .then((itemAdded) {
      if (context.mounted && itemAdded == true) {
        showSnackBar(context, 'Item Added', AnimatedSnackBarType.success);
        loadInitialValues(context);
      }
    });
  }

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }
}
