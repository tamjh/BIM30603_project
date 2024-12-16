import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class buildEwallet extends StatefulWidget {
  const buildEwallet({super.key});

  @override
  State<buildEwallet> createState() => _buildEwalletState();
}

class _buildEwalletState extends State<buildEwallet> {
  @override
  Widget build(BuildContext context) {
    TextEditingController phone = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(10.0.sp),
      child: TextFormField(
        controller: phone,
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
