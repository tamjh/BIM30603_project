import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/model/product_model.dart';
import 'package:project/core/viewmodel/cart_view_model.dart';
import 'package:provider/provider.dart';

import 'BuildButtons.dart';
import 'BuildTotal.dart';

class CartContent extends StatefulWidget {
  const CartContent({super.key});

  @override
  State<CartContent> createState() => _CartContentState();
}

class _CartContentState extends State<CartContent> {
  @override
  void initState() {
    super.initState();
    // Fetch cart items immediately after widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<CartViewModel>(context, listen: false).getAllCart();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double _imageRadius = 88.sp;

    return Consumer<CartViewModel>(
      builder: (context, cartViewModel, child) {
        // Show loading indicator while data is being fetched
        if (cartViewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show empty cart message if no items
        if (cartViewModel.cartItems.isEmpty) {
          return const Center(child: Text("Cart is empty."));
        }

        // Show cart items
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartViewModel.cartItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildImage(
                              _imageRadius, cartViewModel.cartItems[index].product.image),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildName(
                                  context, cartViewModel.cartItems[index].product.name),
                              buildQuantity(
                                context,
                                cartViewModel,
                                cartViewModel.cartItems[index].product,
                                cartViewModel.cartItems[index].quantity,
                              ),
                            ],
                          ),
                        ),
                        buildPrice(
                          context,
                          cartViewModel,
                          cartViewModel.cartItems[index].product.price.toStringAsFixed(2),
                          cartViewModel.cartItems[index].product,
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (!cartViewModel.isLoading && cartViewModel.cartItems.isNotEmpty) ...[
              BuildTotal(total: cartViewModel.getTotalPrice().toStringAsFixed(2)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: BuildButtons(),
              ),
            ],
          ],
        );
      },
    );
  }

  // Helper methods (same as your original implementation)
  Column buildPrice(BuildContext context, CartViewModel cvm, String price, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            cvm.removeFromCart(product);
          },
          icon: Icon(Icons.delete, size: 24.sp),
        ),
        Text(
          "RM$price",
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20.sp),
        ),
      ],
    );
  }

  Row buildQuantity(BuildContext context, CartViewModel cartViewModel, Product product, int quantity) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            cartViewModel.itemDecrement(product);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: Text(
              "-",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "$quantity",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 25.sp),
          ),
        ),
        GestureDetector(
          onTap: () {
            cartViewModel.itemIncrement(product);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: Text(
              "+",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Text buildName(BuildContext context, String productName) {
    return Text(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      productName,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 16.sp),
    );
  }

  Image buildImage(double radius, String img) {
    return Image.asset(
      "assets/images/pro/$img.png",
      width: radius,
      height: radius,
      fit: BoxFit.cover,
    );
  }
}
