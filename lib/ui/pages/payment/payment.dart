import 'package:flutter/material.dart';
import 'package:project/ui/pages/payment/payment_content.dart';
import 'package:project/ui/shared/size_fit.dart';

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
              ?.copyWith(fontSize: 60.px),
        ),
      ),
      body: PaymentContent(),
    );
  }
}
