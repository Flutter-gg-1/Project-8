class CartItem {
  String? id;
  String userId;
  String menuItemId;
  int quantity;
  String? size;
  String? coffeeStrength;
  String? milkOption;
  String? placedOrderId;

  CartItem({
    this.id,
    required this.userId,
    required this.menuItemId,
    this.quantity = 1,
    this.size,
    this.coffeeStrength,
    this.milkOption,
    this.placedOrderId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      userId: json['user_id'],
      menuItemId: json['menu_item_id'],
      quantity: json['quantity'] ?? 1,
      size: json['size'],
      coffeeStrength: json['coffee_strength'],
      milkOption: json['milk_option'],
      placedOrderId: json['placed_order_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'menu_item_id': menuItemId,
      'quantity': quantity,
      'size': size,
      'coffee_strength': coffeeStrength,
      'milk_option': milkOption,
      'placed_order_id': placedOrderId,
    };
  }
}
