class MenuCategory {
  String? id;
  String name;
  String description;
  String? imgUrl;
  int sortPriority;

  MenuCategory(
      {this.id,
      required this.name,
      required this.description,
      this.imgUrl,
      required this.sortPriority});

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      imgUrl: json['img_url'] as String?,
      sortPriority: json['sort_priority'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "img_url": imgUrl,
      "sort_priority": sortPriority,
    };
  }
}
