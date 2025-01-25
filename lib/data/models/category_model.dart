class Category {

  final int id;
  final String name;
  final String image;
  final String updatedAt;
  final String creationAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.updatedAt,
    required this.creationAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      updatedAt: json['updatedAt'] ,
      creationAt: json['creationAt'] ,
    );
  }

  // Method to convert a category into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'updatedAt': updatedAt,
      'creationAt': creationAt,
    };
  }

  Category copyWith({
    int? id,
    String? name,
    String? image,
    String? updatedAt,
    String? creationAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      updatedAt: updatedAt ?? this.updatedAt,
      creationAt: creationAt ?? this.creationAt,
    );
  }
}
