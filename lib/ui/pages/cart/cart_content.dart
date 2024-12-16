import 'package:flutter/material.dart';
import 'package:project/ui/pages/payment/payment.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartContent extends StatelessWidget {
  const CartContent({super.key});

  @override
  Widget build(BuildContext context) {
    final double _imageRadius = 120.sp;
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildImage(_imageRadius),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildName(context),
                              buildQuantity(context),
                            ],
                          ),
                        ),
                        buildPrice(context),
                        SizedBox(
                          width: 10.w,
                        )
                      ],
                    ));
              },
            ),
          ),
          buildTotal(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: buildButtons(context),
          ),
        ],
      ),
    );
  }

  Padding buildTotal(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total amount: ",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 30.sp),
          ),
          Text(
            "RM 520.50",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 25.sp),
          )
        ],
      ),
    );
  }

  Column buildPrice(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min, // Ensure compact size for the column
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete, size: 30.sp),
        ),
        Text(
          "RM 120.50",
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20.sp),
        ),
      ],
    );
  }

  Row buildQuantity(BuildContext context) {
    return Row(
      children: [
        // Decrease button
        GestureDetector(
          onTap: () {
            // Handle decrement logic
          },
          child: Container(
            padding: const EdgeInsets.all(12.0), // Increased padding
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: Text(
              "-",
              style: TextStyle(
                fontSize: 20.sp, // Increased font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0), // Adjusted spacing
          child: Text(
            "1",
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 25.sp),
          ),
        ),
        // Increase button
        GestureDetector(
          onTap: () {
            // Handle increment logic
          },
          child: Container(
            padding: const EdgeInsets.all(12.0), // Increased padding
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: Text(
              "+",
              style: TextStyle(
                fontSize: 20.sp, // Increased font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Text buildName(BuildContext context) {
    return Text(
      "Product A",
      style:
          Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 25.sp),
    );
  }

  Image buildImage(double radius) {
    return Image.asset(
      "assets/images/ph.png",
      width: radius,
      height: radius,
      fit: BoxFit.cover,
    );
  }

  Row buildButtons(BuildContext ctx) {
    return Row(
      children: [
        // Discard Button
        Expanded(
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 5.0), // Adds spacing
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 249, 249, 249),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.black, width: 2.w),
                  ),
                ),
              ),
              onPressed: () {
                
              },
              child: Text(
                "Discard",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        // Check Out Button
        Expanded(
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 5.0), // Adds spacing
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {
                Navigator.pushNamed(ctx, PaymentScreen.routeName);
              },
              child: Text(
                "Check Out",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
