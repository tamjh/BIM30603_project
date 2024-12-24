import 'package:flutter/material.dart';
import 'package:project/core/model/cart_model.dart';
import 'package:project/core/services/cart_service.dart';
import 'package:project/core/model/product_model.dart';
import 'package:project/core/viewmodel/product_view_modal.dart';
import 'package:project/ui/widgets/errorMsg.dart';

class CartViewModel extends ChangeNotifier {
  final CartService _cartService;
  final CartModel _cartModel = CartModel();
  final ProductViewModel _productViewModel;
  final String uid;

  CartViewModel({
    required CartService cartService,
    required ProductViewModel productViewModel,
    required this.uid,
  })  : _cartService = cartService,
        _productViewModel = productViewModel {
    // Initialize cart data when ViewModel is created
    _initializeCart();
  }

  /**
   * variables
   */

  bool _isLoading = false; // Start with false
  List<CartItem> cartItems = [];

  bool get isLoading => _isLoading;



  /**
   * Future
   */
  // Initialize cart data
  Future<void> _initializeCart() async {
    await getAllCart();
  }

  Future<void> getAllCart() async {
    if (_isLoading) return; // Prevent multiple simultaneous calls

    try {
      _isLoading = true;
      notifyListeners();

      List<CartItem> fetchedCartItems = await _cartService.getAllCart(uid, _productViewModel);

      // Update the model and list
      _cartModel.updateCart(fetchedCartItems);
      cartItems = _cartModel.cart;

    } catch (e) {
      //print("Error fetching cart items: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart(BuildContext ctx, Product product) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      notifyListeners();

      // Check if product is already in cart before making any request
      if (!containsProduct(product)) {
        await _cartService.addToCart(uid, product);  // Add product to the cart
        _cartModel.addProduct(product); // Update the local cart
        cartItems = _cartModel.cart;  // Refresh the local cart state
        SnackbarUtils.showMsg(ctx, "Product Added to Cart");
      } else {
        SnackbarUtils.showMsg(ctx, "Product is already in the cart");
      }
    } catch (e) {
      print("Error adding to cart: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeFromCart(Product product) async {

    try {
      if (containsProduct(product)) {
        await _cartService.removeFromCart(uid, product.id);
        _cartModel.removeProduct(product);
        cartItems = _cartModel.cart;
      }
    } catch (e) {
      print("Error removing from cart: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> itemDecrement(Product product) async {
    if (_isLoading || !containsProduct(product)) return;

    try {
      await _cartService.itemDecrement(uid, product.id);

      CartItem existingItem = cartItems.firstWhere(
            (item) => item.product == product,
        orElse: () => CartItem(product: product, quantity: 0),
      );

      if (existingItem.quantity > 1) {
        existingItem.quantity -= 1; // Decrement if quantity > 1
      } else {
        removeFromCart(product); // Remove the item if the quantity is 1
      }
    } catch (e) {
      print("Error decrementing item: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> itemIncrement(Product product) async {
    if (_isLoading || !containsProduct(product)) return;

    try {
      await _cartService.itemIncrement(uid, product.id);
      CartItem existingItem = cartItems.firstWhere(
            (item) => item.product == product,
        orElse: () => CartItem(product: product, quantity: 1),
      );
      existingItem.quantity += 1;
    } catch (e) {
      print("Error incrementing item: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> clearCart() async {

    try {
      notifyListeners();

      await _cartService.clearCart(uid);
      _cartModel.clearCart();
      cartItems.clear();
    } catch (e) {
      print("Error clearing the cart: $e");
    } finally {
      notifyListeners();
    }
  }


  /**
   * methods / function
   */

  double getTotalPrice() => _cartModel.getTotalPrice();
  int getTotalCount() => _cartModel.getTotalCount();
  bool containsProduct(Product product) => _cartModel.containsProduct(product);
  bool isEmpty() {
    return cartItems.isEmpty;
  }
}