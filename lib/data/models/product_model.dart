import 'package:hive/hive.dart';

@HiveType(typeId: 0) // Define a unique typeId for the Product model
class Product {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final String imageUrl;

  @HiveField(5)
  final int stock;

  @HiveField(6)
  final bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stock,
    this.isFavorite = false,
  });

  // Factory method to create a Product from a JSON object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image'] ?? '',
      stock: json['stock'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  // Method to convert a Product into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': imageUrl,
      'stock': stock,
      'isFavorite': isFavorite,
    };
  }

  // Method to copy a product with modifications
  Product copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    int? stock,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      stock: stock ?? this.stock,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
