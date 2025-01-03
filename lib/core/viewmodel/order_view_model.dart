import 'package:flutter/material.dart';
import 'package:project/core/model/address_model.dart';
import 'package:project/core/model/order_model.dart';
import 'package:project/core/services/order_service.dart';

import 'address_view_model.dart';
import 'cart_view_model.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderService _orderService;
  final CartViewModel _cartViewModel;
  final AddressViewModel _addressViewModel;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String get userName => _cartViewModel.user_name;

  String get uid => _cartViewModel.uid;

  double get orderPrice => _cartViewModel.getTotalPrice();

  double get totalPrice => orderPrice + 12;

  bool _disposed = false;

  int orderHistory = 0;

  OrderViewModel({
    required OrderService orderService,
    required CartViewModel cartViewModel,
    required AddressViewModel addressViewModel,
  })  : _orderService = orderService,
        _cartViewModel = cartViewModel,
        _addressViewModel = addressViewModel;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void setLoading(bool value) {
    if (_isLoading == value || _disposed)
      return; // Avoid redundant updates or updates after disposal
    _isLoading = value;
    notifyListeners();
  }

  // Add a getter for default address
  Address? get defaultAddress => _addressViewModel.defaultAddress;

  // Fetch the default address
  Future<Address?> fetchDefaultAddress() async {
    if (_isLoading) return defaultAddress;
    try {
      setLoading(true);
      return await _addressViewModel.fetchDefaultAddress(uid);
    } catch (e) {
      print("Error fetching default address: $e");
      throw Exception("Failed to fetch default address");
    } finally {
      if (!_disposed) {
        setLoading(false);
      }
    }
  }

  // Place a new order
  Future<List> placeOrder(
      String paymentMethod, Map<String, dynamic> paymentContent) async {
    try {
      setLoading(true);

      // Get cart items and total price
      final cartItems = _cartViewModel.cartItems;
      final totalPrice = _cartViewModel.getTotalPrice();

      // Get default address
      final defaultAddress = await fetchDefaultAddress();
      if (defaultAddress == null) {
        throw Exception("No default address found");
      }

      // Manually convert the CartItems' Product objects to maps
      List<Map<String, dynamic>> serializedItems = cartItems.map((cartItem) {
        return {
          'product': {
            'id': cartItem.product.id,
            'name': cartItem.product.name,
            'price': cartItem.product.price,
          },
          'quantity': cartItem.quantity,
        };
      }).toList();

      // Create order
      final order = OrderItem(
        items: serializedItems,
        totalPrice: totalPrice,
        paymentMethod: paymentMethod,
        paymentContent: paymentContent,
        address: defaultAddress,
        name: _cartViewModel.user_name,
        created_at: DateTime.now(),
      );

      // Save order to database
      await _orderService.createOrder(order, uid);

      // Clear cart after order is placed
      await _cartViewModel.clearCart();
      return [userName, totalPrice, defaultAddress.full];
    } catch (e) {
      print("Error placing order: $e");
      throw Exception("Failed to place order: $e");
    } finally {
      if (!_disposed) {
        setLoading(false);
      }
    }
  }

  // Fetch all orders
  Future<List<OrderItem>> getOrders(String uid) async {
    try {
      List<OrderItem> history = await _orderService.getOrders(uid);
      orderHistory = history.length;
      return history;
    } catch (e) {
      throw Exception("Failed to fetch orders: $e");
    }
  }


}
