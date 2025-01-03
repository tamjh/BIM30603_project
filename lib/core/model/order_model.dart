import 'package:cloud_firestore/cloud_firestore.dart';

import 'address_model.dart';
import 'cart_model.dart';

// This is a minor change if needed, otherwise no changes are necessary here.
class OrderItem {
  final List<Map<String, dynamic>> items;
  final double totalPrice;
  final String paymentMethod;
  final Map<String, dynamic> paymentContent;
  final Address address;
  final String name;
  final DateTime created_at;

  OrderItem({
    required this.items,
    required this.totalPrice,
    required this.paymentMethod,
    required this.paymentContent,
    required this.name,
    required this.address,
    required this.created_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'items': items,  // Now directly stores maps of product data
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
      'paymentContent': paymentContent,
      'address': address.toMap(),
      'name': name,
      'created_at': Timestamp.fromDate(created_at),
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      items: List<Map<String, dynamic>>.from(map['items'] ?? []),
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      paymentMethod: map['paymentMethod'] ?? '',
      paymentContent: Map<String, dynamic>.from(map['paymentContent'] ?? {}),
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      name: map['name'] ?? '',
      created_at: (map['created_at'] as Timestamp).toDate(),
    );
  }
}
