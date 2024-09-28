class OrderModel {
  dynamic id;
  int? quantity;
  dynamic orderId;
  dynamic productId;
  String? size;

  OrderModel({this.id, this.quantity, this.orderId, this.productId, this.size});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    quantity = json["quantity"];
    orderId = json["order_id"];
    productId = json["product_id"];
    size = json["size"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["quantity"] = quantity;
    data["order_id"] = orderId;
    data["product_id"] = productId;
    data["size"] = size;
    return data;
  }
}
