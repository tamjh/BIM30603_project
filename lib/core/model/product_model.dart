import 'package:cloud_firestore/cloud_firestore.dart';

// ProductModel is used to manage multiple products in a list
// Use <ProductModel> when working with a collection of products
class ProductModel {
  List<Product> products;

  ProductModel({
    required this.products,
  });

  // Get data from Firestore and store in products list
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        products: List<Product>.from(
          json['products'].map((x) => Product.fromJson(x)),
        ),
      );
}

// Represents a single product
class Product {
  String id;
  String name;
  String image;
  num price;
  String category;
  String brand_id;
  List<Detail> description;
  DateTime created_at;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
    required this.brand_id,
    required this.description,
    required this.created_at,
  });

factory Product.fromJson(Map<String, dynamic> json) {
  var descriptionData = json['description'] ?? '';

  List<Detail> description = [];
  if (descriptionData is String) {
    // First, replace the literal '\n' with actual newlines
    var processedString = descriptionData.replaceAll('\\n', '\n');
    
    // Split by actual newlines
    description = processedString
        .split('\n')
        .where((line) => line.trim().isNotEmpty) // Skip empty lines
        .map((line) {
          var parts = line.split(':');
          
          // if (parts.length < 2) {
          //   return Detail(key: parts[0].trim(), value: 'N/A');
          // }

          return Detail(
            key: parts[0].trim(),
            value: parts.sublist(1).join(':').trim(), // Handle values that might contain colons
          );
        })
        .toList();
  } else if (descriptionData is List) {
    description = List<Detail>.from(
      descriptionData.map((x) => Detail.fromJson(x)),
    );
  }

  return Product(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    image: json['image'] ?? '',
    price: json['price'] ?? 0,
    category: json['category'] ?? '',
    brand_id: json['brand_id'] ?? '',
    description: description,
    created_at: json['created_at'] is Timestamp
        ? (json['created_at'] as Timestamp).toDate()
        : DateTime.now(),
  );
}

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'price': price,
        'category': category,
        'brand_id': brand_id,
        'description': List<dynamic>.from(description.map((x) => x.toJson())),
        'created_at': created_at.toIso8601String(),
      };
}

class Detail {
  String key;
  String value;

  Detail({
    required this.key,
    required this.value,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        key: json['key'] ?? '',
        value: json['value'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };

  @override
  String toString() {
    return '$key: $value'; // Override to print the key and value
  }
}
