class CartItem {
  final String name;
  final int count;
  final double price;
  final String image;
  final String? size;
  final String? coffeeStrength;
  final String? milkOption;

  CartItem({
    required this.name,
    required this.count,
    required this.price,
    required this.image,
    this.size,
    this.coffeeStrength,
    this.milkOption,
  });
}
