import 'package:flutter/material.dart';
import 'package:project/ui/pages/shipping_info/shipping_info_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ShippingInfoScreen extends StatelessWidget {
  static final String routeName = "/shipping_info";
  const ShippingInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shipping Information", style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 25.sp)),
        centerTitle: true,
      ),
      body: ShippingInfoContent(),
    );
  }
}