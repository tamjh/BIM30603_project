import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'PaymentControllerManager.dart';

class buildEwallet extends StatefulWidget {
  buildEwallet({super.key});

  @override
  State<buildEwallet> createState() => _buildEwalletState();
}

class _buildEwalletState extends State<buildEwallet> {
  @override
  Widget build(BuildContext context) {

    final paymentManager = PaymentControllerManager();

    return Padding(
      padding: EdgeInsets.all(10.0.sp),
      child: TextFormField(
        controller: paymentManager.phone,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Phone Number"),
          hintText: "(+60)xxxxxxxxxxx",
        ),
      ),
    );
    ;
  }
}
