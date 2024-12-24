import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/core/model/cart_model.dart';
import 'package:project/core/model/product_model.dart';
import 'package:project/core/viewmodel/product_view_modal.dart';

class CartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add product ID to the cart (store only product_id)
  Future<void> addToCart(String uid, Product product) async {
    try {
      final cartRef = _db.collection('users').doc(uid).collection('carts');

      // Check if the product is already in the cart
      final snapshot = await cartRef.where('productId', isEqualTo: product.id).get();

      if (snapshot.docs.isEmpty) {
        // If the product doesn't exist in the cart, add it
        await cartRef.add({
          'productId': product.id,
          'quantity': 1,
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('Product added to cart.');
      } else {
        print('Product already in cart.');
      }
    } catch (e) {
      print("Error adding to cart: $e");
      throw Exception("Error adding to cart: $e");
    }
  }

  // Fetch cart items and then fetch product details using ProductViewModel
  Future<List<CartItem>> getAllCart(String uid, ProductViewModel productViewModel) async {
    try {
      if (uid.isEmpty) {
        throw Exception("User ID is empty");
      }

      // Fetch cart items from Firestore (only contains productId)
      QuerySnapshot snapshot = await _db.collection('users').doc(uid).collection('carts').get();

      if (snapshot.docs.isEmpty) {
        print("Cart is empty.");
        return []; // Return an empty list if no documents are found
      }

      List<CartItem> carts = await Future.wait(snapshot.docs.map((doc) async {
        var data = doc.data() as Map<String, dynamic>;
        String productId = data['productId'];

        // Fetch the product details using ProductViewModel
        Product product = await productViewModel.fetchProductDetails(productId);

        // Create CartItem with the fetched product details
        return CartItem(product: product, quantity: data['quantity'] ?? 1);
      }).toList());

      return carts;
    } catch (e) {
      //print("Error fetching cart items: $e");
      throw Exception('Error fetching cart items: $e');
    }
  }

  Future<void> itemDecrement(String uid, String pid) async {
    try {
      // Reference to the user's cart collection
      Query<Map<String, dynamic>> itemQuery = _db
          .collection('users')
          .doc(uid)
          .collection('carts')
          .where('productId', isEqualTo: pid);

      // Fetch the documents matching the query
      QuerySnapshot<Map<String, dynamic>> snapshot = await itemQuery.get();

      // Ensure at least one document matches
      if (snapshot.docs.isNotEmpty) {
        // Get the first matching document
        DocumentSnapshot<Map<String, dynamic>> doc = snapshot.docs.first;

        // Get the current quantity
        int currentQuantity = doc.data()?['quantity'] ?? 0;

        // Decrement quantity if it's greater than zero
        if (currentQuantity > 1) {
          await doc.reference.update({'quantity': currentQuantity - 1});
        } else {
          removeFromCart(uid, pid);
        }
      } else {
        print('No matching product found in the cart.');
      }
    } catch (e) {
      print('Error decrementing item: $e');
    }
  }

  Future<void> itemIncrement(String uid, String pid) async {
    try {
      // Reference to the user's cart collection
      Query<Map<String, dynamic>> itemQuery = _db
          .collection('users')
          .doc(uid)
          .collection('carts')
          .where('productId', isEqualTo: pid);

      // Fetch the documents matching the query
      QuerySnapshot<Map<String, dynamic>> snapshot = await itemQuery.get();

      // Ensure at least one document matches
      if (snapshot.docs.isNotEmpty) {
        // Get the first matching document
        DocumentSnapshot<Map<String, dynamic>> doc = snapshot.docs.first;

        // Get the current quantity, defaulting to 0 if it doesn't exist
        int currentQuantity = doc.data()?['quantity'] ?? 0;

        // Increment the quantity
        await doc.reference.update({'quantity': currentQuantity + 1});
        print('Quantity incremented successfully.');
      } else {
        // No matching product found in the cart
        print('No matching product found in the cart.');
      }
    } catch (e) {
      // Log any errors
      print('Error incrementing item: $e');
    }
  }

  Future<void> removeFromCart(String uid, String pid) async {
    try {
      // Reference to the cart collection
      Query<Map<String, dynamic>> itemQuery = _db
          .collection('users')
          .doc(uid)
          .collection('carts')
          .where('productId', isEqualTo: pid);

      // Fetch the matching cart items
      QuerySnapshot<Map<String, dynamic>> snapshot = await itemQuery.get();

      // Check if any document matches
      if (snapshot.docs.isNotEmpty) {
        // Get the first matching document and delete it
        DocumentReference<Map<String, dynamic>> doc = snapshot.docs.first.reference;
        await doc.delete();

        print("Product removed successfully from the cart.");
      } else {
        print("Error: Product not found in the cart.");
      }
    } catch (e) {
      print("Error removing product from cart: $e");
    }
  }

  Future<void> clearCart(String uid) async {
    try {
      // Reference to the user's cart collection
      CollectionReference<Map<String, dynamic>> cartCollection =
      _db.collection('users').doc(uid).collection('carts');

      // Fetch all documents in the collection
      QuerySnapshot<Map<String, dynamic>> snapshot = await cartCollection.get();

      // Iterate through documents and delete them
      for (DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        await doc.reference.delete();
      }

      print("Cart cleared successfully.");
    } catch (e) {
      print("Error clearing the cart: $e");
    }
  }


}
