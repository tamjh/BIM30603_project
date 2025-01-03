import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/core/model/order_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new order
  Future<void> createOrder(OrderItem order, String uid) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('orders')
          .add({
        'items': order.items.map((item) => item).toList(), // No change needed here
        'totalPrice': order.totalPrice,
        'paymentMethod': order.paymentMethod,
        'paymentContent': order.paymentContent,
        'address': order.address.toMap(),
        'name': order.name,
        'created_at': Timestamp.fromDate(order.created_at),
      });
    } catch (e) {
      throw Exception("Failed to create order: $e");
    }
  }


  // Fetch all orders for a user
  Future<List<OrderItem>> getOrders(String uid) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('orders')
          .orderBy('created_at', descending: true)
          .get();

      return snapshot.docs
          .map((doc) {
        // Add error handling for malformed data
        final data = doc.data();
        return OrderItem.fromMap(data);
      })
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch orders: $e");
    }
  }
}
