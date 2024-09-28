import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/cart_Item.dart';

extension CartItemsExt on MockData {
  List<CartItem>? fetchCartItems() {
    return [ CartItem(
        name: "espresso",
        count: 2,
        price: 5, 
        image: "", 
      )];
  }
}
