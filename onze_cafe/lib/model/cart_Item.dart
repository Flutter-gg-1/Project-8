import 'package:onze_cafe/model/menu_item.dart';

class CartItem {
  String id;
  String userId;
  String menuItemId;
  int quantity = 1;
  String? size;
  String? coffeeStrength;
  String? milkOption;
  String? placedOrderId;

  CartItem({
    required this.id,
    required this.userId,
    required this.menuItemId,
    required this.quantity,
    this.size,
    this.coffeeStrength,
    this.milkOption,
    this.placedOrderId,
  });
}
