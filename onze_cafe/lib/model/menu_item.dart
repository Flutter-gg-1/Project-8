class MenuItem {
  String id;
  String categoryId;
  String name;
  int calories;
  double oz;
  String imgUrl;
  String description;
  double price;

  MenuItem(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.calories,
      required this.imgUrl,
      required this.description,
      required this.price,
      required this.oz});
}