import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/services/product_service.dart'; // Your product service import
import 'package:project/core/model/product_model.dart'; // Import your ProductModel

class ProductDetailContent extends StatelessWidget {
  final String id;

  ProductDetailContent({required this.id, super.key});

  Future<Product> fetchProductDetails() async {
    // Instantiate your ProductService and fetch the product details
    final productService = ProductServiceImple();
    return await productService
        .getProductDetails(id); // Ensure this returns a single Product
  }

  @override
  Widget build(BuildContext context) {
    final double screenWdith = MediaQuery.of(context).size.width;
    final double imageWidth = screenWdith * 0.6;
    final double imageHeight = imageWidth * 1.6;

    return FutureBuilder<Product>(
      future: fetchProductDetails(), // Fetch product details
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // Show loading indicator
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
                  "Error: ${snapshot.error}")); // Show error message if there's an error
        } else if (!snapshot.hasData) {
          return Center(child: Text("Product not found"));
        } else {
          final product = snapshot.data!; // Get the product data
          print(product.description[0]
              .value); // Ensure that \n exists in the description

          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Image.asset(
                      "assets/images/pro/${product.image}.png", // Display product image
                      width: imageWidth,
                      height: imageHeight, // Adjust height for responsiveness
                      fit: BoxFit.contain, // Ensure the image fits nicely
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.sp), // Responsive padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
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
                                      .displayMedium
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
                              alignment: Alignment
                                  .centerRight, // Align the text to the right
                              child: Text(
                                "RM ${product.price}", // Display product price
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
                          // Ensure description is split properly by '\n'
                          if (product.description.isNotEmpty)
                            for (var descirption in product.description)
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.sp),
                                child: Text(
                                  "${descirption.key} : ${descirption.value}", // Display each description line
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        fontSize: 16.sp, // Responsive font size
                                      ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                          // Fallback in case description is empty or not properly formatted
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
                child: buildButtons(context),
              ),
            ],
          );
        }
      },
    );
  }

  Widget buildButtons(BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w), // Responsive padding
      child: Row(
        children: [
          // Add to Cart Button
          Expanded(
            child: Container(
              height: 50.h, // Adjust height based on screen height
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {},
                child: Text(
                  "Add to cart",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp), // Responsive font size
                ),
              ),
            ),
          ),
          // Pay Now Button
          Expanded(
            child: Container(
              height: 50.h, // Adjust height based on screen height
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {},
                child: Text(
                  "Pay now",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp), // Responsive font size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
