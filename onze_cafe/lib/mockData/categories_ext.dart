import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/menu_category.dart';

extension Categories on MockData {
  List<MenuCategory> fetchCategories() {
    return [
      MenuCategory(
        id: '1',
        name: 'classic coffee',
        description: '',
        imgUrl: '',
        sortPriority: 1,
      ),
      MenuCategory(
        id: '2',
        name: 'cold coffee',
        description: '',
        imgUrl: '',
        sortPriority: 2,
      ),
      MenuCategory(
        id: '3',
        name: 'tea',
        description: '',
        imgUrl: '',
        sortPriority: 3,
      ),
      MenuCategory(
        id: '4',
        name: 'water',
        description: '',
        imgUrl: '',
        sortPriority: 4,
      ),
      MenuCategory(
        id: '5',
        name: 'focaccia',
        description: '',
        imgUrl: '',
        sortPriority: 5,
      )
    ];
  }
}
