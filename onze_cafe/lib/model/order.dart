class Order {
  String? id;
  String userId;
  String status;
  double price;
  bool isPayed;

  Order({
    this.id,
    required this.userId,
    required this.status,
    required this.price,
    required this.isPayed,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      status: json['status'],
      price: (json['price'] as num).toDouble(), // Casting to double from num
      isPayed: json['is_payed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'status': status,
      'price': price,
      'is_payed': isPayed
    };
  }
}
