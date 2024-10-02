import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/model/offer.dart';
import 'package:onze_cafe/screens/cart/cart_screen.dart';
import 'package:onze_cafe/screens/item_details/item_details_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial()) {}
  List<MenuItem> allItems = [];
  List<MenuCategory> categories = [];
  List<Offer> offers = [];

  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();
  final Map<String, double> categoryPositions = {};
  Map<String, List<MenuItem>> categorizedMenuItems = {};

Future<void> handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
  }
  void fetchMenuItems() {
    allItems = MockData().menuItems;
    categories = MockData().categories;
    offers = MockData().offers;
    _groupMenuItemsByCategory();
    emit(UpdateUIState());
  }

  // Group items by their categoryId
  void _groupMenuItemsByCategory() {
    categorizedMenuItems.clear();
    for (var category in categories) {
      categorizedMenuItems[category.id] =
          allItems.where((item) => item.categoryId == category.id).toList();
    }
  }

  void setCategoryPosition(String categoryId, double position) {
    categoryPositions[categoryId] = position;
  }

  void goToSelectedCategory(String categoryId) {
    if (categoryPositions.containsKey(categoryId)) {
      scrollController.animateTo(
        categoryPositions[categoryId]!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void navigateToCart(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const CartScreen()));

  void navigateToItemDetails(BuildContext context, MenuItem item) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ItemDetailsScreen(item: item)));
}
