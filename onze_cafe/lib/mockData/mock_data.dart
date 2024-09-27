import 'package:onze_cafe/mockData/categories_ext.dart';
import 'package:onze_cafe/mockData/menu_items_ext.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/model/menu_item.dart';

class MockData {
  List<MenuCategory> categories = [];
  List<MenuItem> menuItems = [];

  MockData() {
    _fetchData();
  }

  void _fetchData() {
    categories = fetchCategories();
    menuItems = fetchMenuItems();
  }
}
