import 'package:flutter/material.dart';
import 'package:project/ui/pages/edit_address/edit_address_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditAddress extends StatelessWidget {
  static final String routeName = "/edit_address";
  const EditAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Address",
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(fontSize: 35.sp),
        ),
      ),
      body: EditAddressContent(),
    );
  }
}
