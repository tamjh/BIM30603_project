import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/services/product_service.dart';
import 'package:project/core/model/product_model.dart';
import 'package:project/core/viewmodel/cart_view_model.dart';
import 'package:project/ui/widgets/errorMsg.dart';
import 'package:provider/provider.dart';

class ProductDetailContent extends StatelessWidget {
  final String id;

  const ProductDetailContent({required this.id, super.key});

  Future<Product> fetchProductDetails() async {
    final productService = ProductService();
    return await productService.getProductDetails(id);
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageWidth = screenWidth * 0.6;
    final double imageHeight = imageWidth * 1.6;

    return FutureBuilder<Product>(
      future: fetchProductDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData) {
          return const Center(child: Text("Product not found"));
        } else {
          final product = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Image.asset(
                      "assets/images/pro/${product.image}.png", // Display product image
                      width: imageWidth,
                      height:
                      imageHeight * 0.5, // Adjust height for responsiveness
                      fit: BoxFit.contain, // Ensure the image fits nicely
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.sp), // Responsive padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name, // Display product name
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                    fontSize: 24.sp, // Responsive font size
                                  ),
                                  maxLines: 2,
                                ),
                                Text(
                                  product.brand_id, // Display brand
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                    color: Colors.grey,
                                    fontSize: 16.sp, // Responsive font size
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "RM ${product.price}", // Display price
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                  fontSize: 22.sp, // Responsive font size
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (product.description.isNotEmpty)
                          // Loop through the List<Detail> and display each key and value
                            for (var detail in product.description)
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.sp),
                                child: Text(
                                  "${detail.key}: ${detail.value}", // Display the key and value from the Detail object
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                    fontSize: 16.sp, // Responsive font size
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                          if (product.description.isEmpty)
                            Text(
                              "No description available",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                fontSize: 16.sp, // Responsive font size
                              ),
                              textAlign: TextAlign.justify,
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: buildButtons(context, product, cartViewModel),
              ),
            ],
          );
        }
      },
    );
  }

  Widget buildButtons(BuildContext context, Product product, CartViewModel cartViewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50.h,
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  cartViewModel.addToCart(context, product);
                  Navigator.pop(context);

                },
                child: Text(
                  "Add to cart",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 50.h,
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  // Handle payment logic
                },
                child: Text(
                  "Pay now",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
