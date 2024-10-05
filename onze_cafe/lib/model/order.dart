class Order {
  String? id;
  String userId;
  String status;
  double price;
  bool isPayed;
  DateTime? createdAt;

  Order({
    this.id,
    required this.userId,
    required this.status,
    required this.price,
    required this.isPayed,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      status: json['status'],
      price: (json['price'] as num).toDouble(), // Casting to double from num
      isPayed: json['is_payed'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'status': status,
      'price': price,
      'is_payed': isPayed,
      if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
    };
  }
}
