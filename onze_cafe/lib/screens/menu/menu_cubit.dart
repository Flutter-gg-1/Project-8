import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/screens/cart_screen.dart';
import 'package:onze_cafe/screens/item_details_screen.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial()) {}
  List<MenuItem> menuItems = [];
  List<MenuCategory> categories = [];

  void fetchMenuItems() {
    menuItems = MockData().menuItems;
    emit(UpdateUIState());
  }

  void fetchCategories() {
    categories = MockData().categories;
    emit(UpdateUIState());
  }

  void navigateToCart(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const CartScreen()));

  void navigateToItemDetails(BuildContext context, MenuItem item) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ItemDetailsScreen(item: item)));
}
