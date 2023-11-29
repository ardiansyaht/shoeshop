// models/shoe.dart
class Shoe {
  final String name;
  final String price;
  final String description;
  final String imagePath;
  bool isFavorite;

  Shoe({
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    this.isFavorite = false, // Set defaultnya ke false
  });
}
