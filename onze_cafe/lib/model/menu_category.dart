class MenuCategory {
  String? id;
  String name;
  String description;
  String imgUrl;
  int sortPriority;

  MenuCategory(
      { this.id,
      required this.name,
      required this.description,
      required this.imgUrl,
      required this.sortPriority});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "imgUrl": imgUrl,
      "sortPriority": sortPriority,
    };
  }
}
