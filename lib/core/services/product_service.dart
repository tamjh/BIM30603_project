import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/core/model/product_model.dart';

abstract class ProductService {
  Future<Product> getProductDetails(String id);
}

class ProductServiceImple implements ProductService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<Product> getProductDetails(String id) async {
    if (id.isEmpty) {
      throw Exception("Product ID cannot be empty.");
    }

    try {
      // Fetch the product document from Firestore
      final doc = await db.collection('products').doc(id).get();

      if (doc.exists) {
        // Convert the Firestore document to a Product model
        return Product.fromJson(doc.data()!..['id'] = doc.id);
      } else {
        throw Exception("Product with ID $id not found.");
      }
    } catch (e) {
      throw Exception("Error fetching product details: $e");
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    try {
      // Fetch all products from Firestore
      final querySnapshot = await db.collection('products').get();

      // Map Firestore documents to a list of Product models
      return querySnapshot.docs.map((doc) {
        return Product.fromJson(doc.data()!..['id'] = doc.id);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }
}
