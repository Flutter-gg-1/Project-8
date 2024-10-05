import 'package:onze_cafe/mockData/cart_items_ext.dart';
import 'package:onze_cafe/mockData/categories_ext.dart';
import 'package:onze_cafe/mockData/menu_items_ext.dart';
import 'package:onze_cafe/mockData/offers_ext.dart';
import 'package:onze_cafe/mockData/placed_orders_ext.dart';
import 'package:onze_cafe/mockData/profile_ext.dart';
import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/model/placed_order.dart';

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
  List<CartItem> cart = [];
  List<PlacedOrder> placedOrders = [];

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
    placedOrders = fetchPlacedOrders();
  }
}
