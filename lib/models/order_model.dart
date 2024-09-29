import 'package:onze_cafe/models/item_model.dart';

class OrderModel {
  final int orderId;
  final String userId;
  final String status;
  final DateTime placedAt;
  final DateTime readyAt;
  final double totalPrice;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.status,
    required this.placedAt,
    required this.readyAt,
    required this.totalPrice
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'],
      userId: json['user_id'],
      status: json['status'],
      placedAt: DateTime.parse(json['placed_at']),
      readyAt: DateTime.parse(json['ready_at']),
      totalPrice: json['total_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'status': status,
      'placed_at': placedAt.toString(),
      'ready_at': readyAt.toString(),
      'total_price': totalPrice,
    };
  }
}
