import 'package:flutter/material.dart';
import 'package:project/ui/pages/order_history/order_history_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHistory extends StatelessWidget {
  static final String routeName = "/orderhistory";
  const OrderHistory ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders", style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 35.sp)),
        centerTitle: false,
        // leading: Icon(Icons.arrow_back_ios_new),
      ),
      body: OrderHistoryContent(),
    );
  }
}