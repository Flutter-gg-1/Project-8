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
        size: CupSize.small.strValue(),
        placedOrderId: '1',
      ),
    ];
  }
}
