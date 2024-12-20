import 'dart:convert';

//ProductModel is use to manage multiple product into a List
//use <ProductModel> while collection of product
class ProductModel {
  //many product in list
  List<Product> products;

  //constructor
  ProductModel({
    required this.products,
  });

  //get data from firstore
  //then store in products list
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        products: List<Product>.from(
            json['products'].map((x) => Product.fromJson(x))),
      );
}

//for one product
class Product {
  String id;
  String name;
  String image;
  num price;
  String category;
  String brand_id;
  List<Detail> description; // Now description is a list of details.

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
    required this.brand_id,
    required this.description,
  });

factory Product.fromJson(Map<String, dynamic> json) {
  // Fetch description
  var descriptionData = json['description'];
  // print('Raw description data: $descriptionData'); // Debugging line

  // Replace escaped newline character (\n or \\n) with actual newline
  descriptionData = descriptionData.replaceAll(r'\n', '\n');  // Handle escaped newline

  // Verify and print each character to see if the newline is \n, \r, or \r\n
  // print('Raw description characters:');


  List<Detail> description = [];

  if (descriptionData is String) {
    // Now split the description using the actual newline character
    description = descriptionData
        .split('\n') // Split by actual newline character
        .map((line) => line.trim())  // Remove leading/trailing spaces
        .where((line) => line.isNotEmpty)  // Filter out empty lines
        .map((line) {
          var parts = line.split(':');
          if (parts.length >= 2) {
            // Proper key-value pair found
            return Detail(
              key: parts[0].trim(),
              value: parts[1].trim(),
            );
          } else {
            // If no key-value pair exists (like the case with "Colour"), treat the line as a key
            return Detail(
              key: parts[0].trim(),
              value: '', // Empty value for incomplete lines
            );
          }
        }).toList();
  } else if (descriptionData is List) {
    // If description is already a list, parse each item as a Detail object
    description = List<Detail>.from(
      descriptionData.map((x) => Detail.fromJson(x)),
    );
  }

  // Print cleaned description data
  // description.forEach((detail) {
  //   print('Description Key: ${detail.key}, Value: ${detail.value}');
  // });

  return Product(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    image: json['image'] ?? '',
    price: json['price'] ?? 0,
    category: json['category'] ?? '',
    brand_id: json['brand_id'] ?? '',
    description: description,
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
}
