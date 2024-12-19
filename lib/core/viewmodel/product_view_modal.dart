import 'package:flutter/material.dart';
import 'package:project/core/model/product_model.dart';
import 'package:project/core/services/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  /// -----------------------------------------------------------------
  ///
  ///  Variable
  ///
  /// -----------------------------------------------------------------
  final Product? _product;
  List<Product>? _products = [];
  bool isFavourite;
  final ProductService _productService;

  /// -----------------------------------------------------------------
  ///
  ///  Constructor
  ///
  /// -----------------------------------------------------------------
  // Constructor for single product
  ProductViewModel.single(this._product, this._productService,
      {this.isFavourite = false})
      : _products = null;

  // Constructor for multiple products
  ProductViewModel.all(this._products, this._productService,
      {this.isFavourite = false})
      : _product = null;

  /// -----------------------------------------------------------------
  ///
  ///  Getter
  ///
  /// -----------------------------------------------------------------
  List<Product> get products => _products ?? [];

  // Getters for properties - single product case
  String get id => _product?.id ?? '';
  String get name => _product?.name ?? '';
  String get image => _product?.image ?? '';
  num get price => _product?.price ?? 0;
  String get category => _product?.category ?? '';
  String get brand => _product?.brand_id ?? '';

  // Format description for single product
  List<String> get description => _product != null
      ? _product.description
          .map((d) => '${d.key}: ${d.value}')
          .where((line) => line.isNotEmpty) // Exclude incomplete lines
          .toList()
      : [];

  // Return formatted product price for single product
  String get formattedPrice => "\$${price.toStringAsFixed(2)}";

  /// -----------------------------------------------------------------
  ///
  ///  Future
  ///
  /// -----------------------------------------------------------------
  // Fetch all products (for multiple products scenario)
  Future<void> fetchAllProducts() async {
    try {
      final products = await _productService.fetchProducts();
      _products = products;
      notifyListeners();
    } catch (e) {
      print("Error fetching products: $e");
      throw Exception("Error fetching products: $e");
    }
  }

  // Fetch product details (for single product scenario)
  Future<Product> fetchProductDetails(String id) async {
    try {
      final product = await _productService.getProductDetails(id);
      return product;
    } catch (e) {
      print("Error fetching product details: $e");
      throw Exception("Error fetching product details: $e");
    }
  }

  /// -----------------------------------------------------------------
  ///
  ///  function
  ///
  /// -----------------------------------------------------------------
  // Method to toggle favourite status
  void toggleFavouriteStatus() {
    isFavourite = !isFavourite;
  }

  // Method to check if the product is favourite
  bool isProductFavourite(String productId) {
    // Implement your logic to check if a product is in the favourites list
    return isFavourite; // Simplified logic, you can extend this for a list of favourites
  }
}
