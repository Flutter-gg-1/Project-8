import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/models/order_item_model.dart';

class CartModel {
  final List<OrderItemModel> items = [];

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void addItem(ItemModel item, int quantity) {
    items.add(OrderItemModel(
      itemId: item.id,
      orderId: 0,
      quantity: quantity,
      price: item.price,
    ));
  }

  void removeItem(int itemId) {
    items.removeWhere((item) => item.itemId == itemId);
  }

  void clearCart() {
    items.clear();
  }
}
