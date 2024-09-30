class OrderItemModel {
  final int itemId;
  final int orderId;
  int quantity;
  final double price;

  OrderItemModel({
    required this.itemId,
    required this.orderId,
    required this.quantity,
    required this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      itemId: json['item_id'],
      orderId: json['order_id'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'order_id': orderId,
      'quantity': quantity,
      'price': price,
    };
  }
}
