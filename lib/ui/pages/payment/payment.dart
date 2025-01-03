import 'package:flutter/material.dart';
import 'package:project/ui/pages/payment/payment_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentScreen extends StatefulWidget {
  static final String routeName = "/payment_form";
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    print("Payment dispose");

    super.dispose();
  }

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
