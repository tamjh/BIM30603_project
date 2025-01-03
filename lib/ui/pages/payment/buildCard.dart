import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'PaymentControllerManager.dart';

class buildCard extends StatefulWidget {

  buildCard({super.key});

  @override
  State<buildCard> createState() => _buildCardState();
}

class _buildCardState extends State<buildCard> {

  final paymentManager = PaymentControllerManager();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Column(
        children: [
          TextFormField(
            controller: paymentManager.cardNumber,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Card Number"),
              hintText: "1234 1234 1234",
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: paymentManager.expDate,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Expire Date"),
                    hintText: "MM / YY",
                  ),
                ),
              ),
              SizedBox(width: 20.h),
              Expanded(
                child: TextFormField(
                  controller: paymentManager.cvv,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("CVV"),
                    hintText: "789",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
