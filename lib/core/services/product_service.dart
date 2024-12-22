
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/core/model/fav_model.dart';
import 'package:project/core/model/product_model.dart';

class ProductService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Reusable collection references
  CollectionReference get _productRef => db.collection('products');
  CollectionReference _userFavourites(String userId) =>
      db.collection('users').doc(userId).collection('favourites');

/* -----------------------------------------------------------------------

ABOUT PRODUCT 

-------------------------------------------------------------------------
*/
  // Get certain product detail
Future<Product> getProductDetails(String id) async {
    if (id.isEmpty) throw Exception("Product ID cannot be empty.");

    try {
      final doc = await _productRef.doc(id).get();

      if (doc.exists) {
        return Product.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      } else {
        throw Exception("Product with ID $id not found.");
      }
    } catch (e) {
      throw Exception("Error fetching product details: $e");
    }
  }

  // Fetch all products
  Future<List<Product>> fetchProducts() async {
    try {
      final querySnapshot = await _productRef.get();

      return querySnapshot.docs.map((doc) {
        return Product.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }).toList();
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }


/* -----------------------------------------------------------------------

ABOUT FAVOURITE ITEM 

-------------------------------------------------------------------------
*/

  // Get all favs for a user
  Future<List<Favourite>> getFavItems(String userId) async {
    try {
      final querySnapshot = await _userFavourites(userId).get();

      return querySnapshot.docs.map((doc) {
        return Favourite.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }).toList();
    } catch (e) {
      throw Exception("Error fetching favourites: $e");
    }
  }

  // Add to favourites
  Future<void> addFavItem(String userId, Favourite favourite) async {
    try {
      await _userFavourites(userId).add(favourite.toJson());
    } catch (e) {
      throw Exception("Error adding favourite: $e");
    }
  }

  // Remove from favourites
  Future<void> removeFavItem(String userId, String productId) async {
    try {
      // Reference to the user's favourites collection
      final favRef = db.collection('users').doc(userId).collection('favourites');

      // Find the document that matches the productId
      final querySnapshot = await favRef.where('productId', isEqualTo: productId).get();

      // If a matching document is found, delete it
      if (querySnapshot.docs.isNotEmpty) {
        final favDoc = querySnapshot.docs.first;
        await favDoc.reference.delete();
        print("Favorite removed successfully from Firestore!");
      } else {
        print("Favorite not found for productId: $productId");
      }
    } catch (e) {
      throw Exception("Error removing favourite item: $e");
    }
  }
}
