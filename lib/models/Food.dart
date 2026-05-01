
class Food {
  final String name;
  final String desc;
  final String imgPath;
  final double price;
  final FoodCategory category;
  List<Addon> availableAddons;
  Food({
    required this.name,
    required this.desc,
    required this.imgPath,
    required this.price,
    required this.category,
    required this.availableAddons,
  });
}
enum FoodCategory{
  burgers,
  salads,
  sides,
  desserts,
  drinks,
}
class Addon{
  String name;
  double price;
  Addon({
    required this.name,
    required this.price,
  });
}