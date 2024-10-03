class Offer {
  String? id;
  String menuItemId;
  double price;
  String startDate;
  String endDate;

  Offer({
    this.id,
    required this.menuItemId,
    required this.price,
    required this.startDate,
    required this.endDate,
  });

  // Factory constructor for fromJson
  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      menuItemId: json['menu_item_id'],
      price:
          (json['price'] as num).toDouble(), // Ensures price is always double
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }

  // Method for toJson
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'menu_item_id': menuItemId,
      'price': price,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
