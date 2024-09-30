import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/models/order_item_model.dart';

class CartModel {
  final List<OrderItemModel> items = [];

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void addItem({required OrderItemModel item}) {
    items.add(item);
  }

  void removeItem(int itemId) {
    items.removeWhere((item) => item.itemId == itemId);
  }

  void clearCart() {
    items.clear();
  }
}
