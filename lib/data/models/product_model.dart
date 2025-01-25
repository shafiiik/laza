class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      images: (json['images'] as List<dynamic>).map((image) => image as String).toList(),
    );
  }

  // Method to convert a Product into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': images,
    };
  }

  // Method to copy a product with modifications
  Product copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    List<String>? images,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      images: images ?? this.images,
    );
  }
}
