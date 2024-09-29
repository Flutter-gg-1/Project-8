class ProductModel {
  dynamic productId;
  String? name;
  int? cal;
  int? price;
  String? type;
  int? preparationTime;
  String? des;

  ProductModel(
      {this.productId,
      this.name,
      this.cal,
      this.price,
      this.type,
      this.preparationTime,
      this.des});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json["product_id"];
    name = json["name"];
    cal = json["cal"];
    price = json["price"];
    type = json["type"];
    preparationTime = json["preparation_time"];
    des = json["des"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["product_id"] = productId;
    data["name"] = name;
    data["cal"] = cal;
    data["price"] = price;
    data["type"] = type;
    data["preparation_time"] = preparationTime;
    data["des"] = des;
    return data;
  }
}
