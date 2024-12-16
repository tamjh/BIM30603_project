import 'package:project/core/model/product_model.dart';
import 'package:project/core/services/firebase_service.dart';

abstract class HomeService {
  Future<List<Product>> getHotProducts();
  Future<List<Product>> getNewProducts();
}
 // For generating random numbers

class HomeServicesImpl implements HomeService {
  final firestoreService = FirestoreServices.instance;

  @override
  Future<List<Product>> getHotProducts() async {
    // Get all products and shuffle them to select a random set
    final products = await firestoreService.getCollection(
      path: "products/",
      builder: (data, documentId) => Product.fromJson({
        ...data!,
        'id': documentId,
      }),
    );

    // Shuffle the list of products randomly
    products.shuffle();

    // You can adjust the number of products you want to fetch here
    final randomHotProducts = products.take(10).toList(); // Takes 10 random products

    return randomHotProducts;
  }

  @override
  Future<List<Product>> getNewProducts() async {
    // Get all products and shuffle them to select a random set
    final products = await firestoreService.getCollection(
      path: "products/",
      builder: (data, documentId) => Product.fromJson({
        ...data!,
        'id': documentId,
      }),
    );

    // Shuffle the list of products randomly
    products.shuffle();

    // You can adjust the number of products you want to fetch here
    final randomNewProducts = products.take(10).toList(); // Takes 10 random products

    return randomNewProducts;
  }
}
