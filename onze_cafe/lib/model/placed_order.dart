class PlacedOrder {
  String? id;
  String userId;
  String status;

  PlacedOrder({
    this.id,
    required this.userId,
    required this.status,
  });

  factory PlacedOrder.fromJson(Map<String, dynamic> json) {
    return PlacedOrder(
      id: json['id'],
      userId: json['user_id'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'status': status,
    };
  }
}
