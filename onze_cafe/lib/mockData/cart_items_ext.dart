import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/model/enums/cup_size.dart';

extension CartItemsExt on MockData {
  List<CartItem> fetchCartItems() {
    return [
      CartItem(
        id: '1',
        userId: '1',
        menuItemId: '1',
        quantity: 3,
        size: CupSize.small.name(),
        placedOrderId: '1',
      ),
      CartItem(
        id: '2',
        userId: '1',
        menuItemId: '2',
        quantity: 3,
        size: CupSize.small.name(),
        placedOrderId: '1',
      ),
      CartItem(
        id: '3',
        userId: '1',
        menuItemId: '5',
        quantity: 3,
        size: CupSize.small.name(),
        placedOrderId: '2',
      ),
      CartItem(
        id: '4',
        userId: '1',
        menuItemId: '3',
        quantity: 3,
        size: CupSize.small.name(),
        placedOrderId: '2',
      ),
      CartItem(
        id: '5',
        userId: '1',
        menuItemId: '2',
        quantity: 3,
        size: CupSize.small.name(),
      ),
    ];
  }
}
