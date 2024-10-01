import 'package:customer_app/models/product_model.dart';

class OrderModel {

  String? orderId;
  String? customerId;
  String? employeeId;
  int? totalPrice;
  DateTime? time;
  int? totalPreparationTime;
  String? status;

  OrderModel(
      {this.orderId,
      this.customerId,
      this.employeeId,
      this.totalPrice,
      this.time,
      this.totalPreparationTime,
      this.status});


  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json["order_id"];
    customerId = json["customer_id"];
    employeeId = json["employee_id"];
    totalPrice = json["total_price"];
    time = json["time"];
    totalPreparationTime = json["total_preparation_time"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["order_id"] = orderId;
    data["customer_id"] = customerId;
    data["employee_id"] = employeeId;
    data["total_price"] = totalPrice;
    data["time"] = time;
    data["total_preparation_time"] = totalPreparationTime;
    data["status"] = status;
    return data;
  }
}
