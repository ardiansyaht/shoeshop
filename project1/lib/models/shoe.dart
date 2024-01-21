// models/shoe.dart
class Shoe {
  final String id;
  final String name;
  final String price;
  final String description;
  String imagePath;
  bool isFavorite; // Tambahkan tanda tanya untuk mengizinkan nilai null

  Shoe({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    this.isFavorite = false,
  });

  // Metode untuk membuat objek Shoe dari Map
  factory Shoe.fromMap(Map<String, dynamic> map) {
    return Shoe(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      imagePath: map['imagePath'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  // Metode untuk mengubah objek Shoe menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price.toString(),
      'description': description,
      'imagePath': imagePath,
      'isFavorite': isFavorite,
    };
  }
}

