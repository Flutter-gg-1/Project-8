class MenuItem {
  String? id;
  String categoryId;
  String name;
  int calories;
  double oz;
  String? imgUrl;
  double price;

  MenuItem({
    this.id,
    required this.categoryId,
    required this.name,
    required this.calories,
    this.imgUrl,
    required this.price,
    required this.oz,
  });

  // Factory constructor for fromJson
  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      calories: json['calories'],
      oz: (json['oz'] as num).toDouble(),
      imgUrl: json['img_url'] as String?,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'category_id': categoryId,
      'name': name,
      'calories': calories,
      'oz': oz,
      'img_url': imgUrl,
      'price': price,
    };
  }
}
