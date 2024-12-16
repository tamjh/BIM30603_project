import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/ui/pages/payment/buildBottomNav.dart';
import 'package:project/ui/pages/payment/buildCard.dart';
import 'package:project/ui/pages/payment/buildEwallet.dart';
import 'package:project/ui/pages/payment/buildShippingInfo.dart';
import 'package:project/ui/pages/payment/buildSubTitle.dart';

class PaymentContent extends StatefulWidget {
  const PaymentContent({super.key});

  @override
  State<PaymentContent> createState() => _PaymentContentState();
}

class _PaymentContentState extends State<PaymentContent> {
  String selectedMethod = "Debit Card/Credit Card";

  final Map<String, Widget> paymentMethods = {
    "FPX": Icon(Icons.payment),
    "Debit Card/Credit Card": Icon(Icons.credit_card),
    "Touch n Go": Icon(Icons.account_balance_wallet),
  };

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSubTitle(title: "Shipping Information",),
          SizedBox(height: 20.h),
          buildShippingInfo(),
          SizedBox(height: 20.h),
          buildMethod(context),
          SizedBox(height: 20.h),
          if (selectedMethod == "Debit Card/Credit Card") buildCard(),
          if (selectedMethod == "Touch n Go") buildEwallet(),
        ],
      ),
    ),
    bottomNavigationBar: buildBottomNav()
  );
}
  Widget buildMethod(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSubTitle(title: "Select Payment Method"),
        SizedBox(height: 20.h),
        DropdownButtonFormField<String>(
          value: selectedMethod,
          items: paymentMethods.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    entry.value,
                    SizedBox(width: 10.w),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(entry.key, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedMethod = newValue!;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Payment Method",
          ),
        ),
      ],
    );
  }
}