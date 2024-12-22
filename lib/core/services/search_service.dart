import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/core/model/product_model.dart';

class SearchService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// -----------------------------------------------------------------
  /// Fetch All Keywords
  /// -----------------------------------------------------------------
  Future<List<String>> getAllKeywords() async {
    try {
      // Query the 'products' collection to get all documents
      QuerySnapshot querySnapshot = await _db.collection('products').get();

      // debugForQuery(querySnapshot);
      List<String> keywords = [];

      // Iterate through the products and get the brand_id and category
      for (var doc in querySnapshot.docs) {
        String brandId = doc['brand_id'] ?? '';
        String category = doc['category'] ?? '';

        // Add brand_id and category to the list if not already present
        if (!keywords.contains(brandId) && brandId.isNotEmpty) {
          keywords.add(brandId);
        }
        if (!keywords.contains(category) && category.isNotEmpty) {
          keywords.add(category);
        }
      }

      // Sort keywords in descending order
      keywords.sort((fir, sec) => sec.compareTo(fir));

      return keywords;
    } catch (e) {
      throw Exception("Failed to fetch keywords: ${e.toString()}");
    }
  }

  /// -----------------------------------------------------------------
  /// Search Items
  /// -----------------------------------------------------------------
  Future<List<Product>> searchItems(
      String searchTxt, List<String> selectedBrands) async {
    try {
      // Query the 'products' collection to get all documents
      QuerySnapshot querySnapshot = await _db.collection('products').get();

      List<Product> products = [];

      for (var doc in querySnapshot.docs) {
        // Parse the document data
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Add the document ID to the data map
        data['id'] = doc.id;
        // debugForQuery(querySnapshot);
        // Convert search-related fields to lowercase
        String name = data['name']?.toLowerCase() ?? '';
        String brandId = data['brand_id']?.toLowerCase() ?? '';
        String category = data['category']?.toLowerCase() ?? '';

        // Convert search text and selected brands to lowercase
        String searchTxtLower = searchTxt.toLowerCase();
        List<String> selectedBrandsLower =
            selectedBrands.map((brand) => brand.toLowerCase()).toList();

        // Check if the search text matches relevant fields
        bool matchesSearchTxt = searchTxt.isEmpty ||
            name.contains(searchTxtLower) ||
            brandId.contains(searchTxtLower) ||
            category.contains(searchTxtLower);

        // Check if the brand_id or category matches the selected filters
        bool matchesSelectedBrand = selectedBrandsLower.isEmpty ||
            selectedBrandsLower.contains(brandId) ||
            selectedBrandsLower.contains(category);

        if (matchesSearchTxt && matchesSelectedBrand) {
          products.add(Product.fromJson(data));
        }
      }

      //debugging(products);

      return products;
    } catch (e) {
      throw Exception("Failed to search items: ${e.toString()}");
    }
  }

  /// -----------------------------------------------------------------
  /// Debugging Utilities
  /// -----------------------------------------------------------------
  void debugging(List<Product> products) {
    // Debugging: Print the matching products
    for (var product in products) {
      print("-----------------------------------");
      print("Product: ${product.name}");
      print("Brand: ${product.brand_id}");
      print("Category: ${product.category}");
      print("Description: ${product.description.join(", ")}");
      print("-----------------------------------");
    }
  }

  void debugForQuery(QuerySnapshot querySnapshot) {
    // Debugging: Print the document data
    for (final doc in querySnapshot.docs) {
      print("Document data: ${doc.data()}");
    }
  }
}
