class ItemModel {
  final int id;
  final String name;
  final String description;
  final String size;
  final double price;
  final int preparationTime;
  final String itemType;
  final String imageUrl;
  final int rating;

  ItemModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.size,
      required this.price,
      required this.preparationTime,
      required this.itemType,
      required this.imageUrl,
      required this.rating
      });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        size: json['size'] ?? 'small',
        price: json['price'],
        preparationTime: json['preparation_time'],
        itemType: json['item_type'],
        imageUrl: json['image_url'] ??
            'assets/woman-drinking-coffee-reusable-pot-character.png',
            rating: json['rating'] ?? 0
            );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'size': size,
      'price': price,
      'preparation_time': preparationTime,
      'item_type': itemType,
      'image_url': imageUrl,
      'rating': rating
    };
  }
}
