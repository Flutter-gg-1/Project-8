import 'package:flutter/cupertino.dart';
import 'package:onze_cafe/mockData/cart_items.dart';
import 'package:onze_cafe/mockData/categories_ext.dart';
import 'package:onze_cafe/mockData/menu_items_ext.dart';
import 'package:onze_cafe/mockData/offers_ext.dart';
import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/model/menu_item.dart';

class MockData {
  List<MenuCategory> categories = [];
  List<MenuItem> menuItems = [];
  List<AssetImage> offerce = [];
  List<CartItem>? cart = [];

  MockData() {
    _fetchData();
  }

  void _fetchData() {
    categories = fetchCategories();
    menuItems = fetchMenuItems();
    offerce = fetchOfferce();
    cart = fetchCartItems();
  }
}
