import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/menu_item.dart';

extension MenuItemsExt on MockData {
  List<MenuItem> fetchMenuItems() {
    return [
      MenuItem(
          id: '1',
          categoryId: '1',
          name: 'espresso',
          calories: 5,
          imgUrl: '',
          price: 7,
          oz: 8),
      MenuItem(
          id: '2',
          categoryId: '1',
          name: 'americano',
          calories: 5,
          imgUrl: '',
          price: 7,
          oz: 8),
      MenuItem(
          id: '3',
          categoryId: '1',
          name: 'latte',
          calories: 5,
          imgUrl: '',
          price: 7,
          oz: 16),
      MenuItem(
          id: '4',
          categoryId: '2',
          name: 'ice latte',
          calories: 5,
          imgUrl: '',
          price: 7,
          oz: 12),
      MenuItem(
          id: '5',
          categoryId: '2',
          name: 'ice spanish',
          calories: 5,
          imgUrl: '',
          price: 7,
          oz: 10),
      MenuItem(
          id: '6',
          categoryId: '2',
          name: 'ice v60',
          calories: 5,
          imgUrl: '',
          price: 7,
          oz: 8),
    ];
  }
}
