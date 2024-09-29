import 'package:flutter/cupertino.dart';
import 'package:onze_cafe/mockData/cart_items.dart';
import 'package:onze_cafe/mockData/categories_ext.dart';
import 'package:onze_cafe/mockData/menu_items_ext.dart';
import 'package:onze_cafe/mockData/offers_ext.dart';
import 'package:onze_cafe/mockData/profile_ext.dart';
import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/model/menu_item.dart';

import '../model/offer.dart';
import '../model/profile.dart';

class MockData {
  // Private static instance variable
  static final MockData _instance = MockData._internal();

  // Public fields
  List<MenuCategory> categories = [];
  List<MenuItem> menuItems = [];
  List<Offer> offers = [];
  List<Profile> profiles = [];
  List<AssetImage> offerce = [];
  List<CartItem> cart = [];

  MockData._internal() {
    _fetchData();
  }

  factory MockData() {
    return _instance;
  }

  // Method to fetch data
  void _fetchData() {
    categories = fetchCategories();
    menuItems = fetchMenuItems();
    offers = fetchOffers();
    profiles = fetchProfiles();
    cart = fetchCartItems();
  }

  MenuItem? getMenuItemById(String menuItemId) {
    return menuItems.firstWhere((menuItem) => menuItem.id == menuItemId);
  }
}
