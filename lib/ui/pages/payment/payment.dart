import 'package:flutter/material.dart';
import 'package:project/ui/pages/payment/payment_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentScreen extends StatelessWidget {
  static final String routeName = "/payment_form";
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(fontSize: 35.sp),
        ),
      ),
      body: PaymentContent(),
    );
  }
}
