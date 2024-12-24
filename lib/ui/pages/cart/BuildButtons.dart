import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/viewmodel/cart_view_model.dart';
import 'package:project/ui/pages/payment/payment.dart';
import 'package:provider/provider.dart';

class BuildButtons extends StatelessWidget {
  const BuildButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cartViewModel, child) {
        return Row(
          children: [
            // Clear Button
            Expanded(
              child: Container(
                height: 40.h,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                // Adds spacing
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
                  onPressed: cartViewModel.isEmpty()
                      ? null
                      : () {
                    cartViewModel.clearCart();
                  },
                  child: Text(
                    "Clear",
                    style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  ),
                ),
              ),
            ),
            // Checkout Button
            Expanded(
              child: Container(
                height: 40.h,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                // Adds spacing
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      cartViewModel.isEmpty() ? Colors.grey : Colors.red,
                    ),
                  ),
                  onPressed: cartViewModel.isEmpty()
                      ? null
                      : () {
                    Navigator.pushNamed(context, PaymentScreen.routeName);
                  },
                  child: Text(
                    cartViewModel.isEmpty() ? "Go Shop" : "Check Out",
                    style: TextStyle(color: Colors.white, fontSize: 24.sp),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
