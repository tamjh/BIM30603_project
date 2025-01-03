import 'package:project/core/model/product_model.dart';

class CartModel {
  List<CartItem> cart = [];

  // Add a product to the cart (with quantity handling)
  void addProduct(Product product, int quantity) {
    final existingItem = cart.firstWhere(
          (item) => item.product == product,
      orElse: () => CartItem(product: product, quantity: 0), // Return a default CartItem with quantity 0 if not found
    );

    if (existingItem.quantity == 0) {
      cart.add(CartItem(product: product, quantity: quantity)); // Add new product with quantity 1
    } else {
      existingItem.quantity += 1; // Increment quantity if the product is already in the cart
    }
  }

  // Remove a product from the cart
  void removeProduct(Product product) {
    cart.removeWhere((item) => item.product == product);
  }

  // Get total price of all items in the cart
  double getTotalPrice() {
    return cart.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  // Get total count of items in the cart (including quantities)
  int getTotalCount() {
    return cart.fold(0, (sum, item) => sum + item.quantity);
  }

  // Check if a product is already in the cart
  bool containsProduct(Product product) {
    return cart.any((item) => item.product.name == product.name);
  }

  // Clear the cart
  void clearCart() {
    cart.clear();
  }

  void updateCart(List<CartItem> cartItems) {
    clearCart();
    cartItems.forEach((item) {
      cart.add(item);
    });
  }

  void debugging(){
    cart.forEach((i){
      print("------------------------");
      print(i.product.name);
      print(i.product.description);
      print(i.quantity);
      print("------------------------");
    });
  }
}

// A CartItem class to store products along with their quantity
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
  // Convert a Map into a CartItem
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromJson(map['product']),
      quantity: map['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toJson(), // Convert the Product object to a map
      'quantity': quantity,
    };
  }

}
