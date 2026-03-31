import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final int? id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String thumbnail;
  final double rating;

  Product({
    this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.thumbnail,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    title: json['title'] ?? '',
    price: (json['price'] as num).toDouble(),
    description: json['description'] ?? '',
    category: json['category'] ?? '',
    thumbnail: json['thumbnail'] ?? '',
    rating: (json['rating'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() {
    final map = {
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'thumbnail': thumbnail,
      'rating': rating,
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }
}
