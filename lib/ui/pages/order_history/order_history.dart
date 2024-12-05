import 'package:flutter/material.dart';
import 'package:project/ui/pages/main/main.dart';
import 'package:project/ui/pages/order_history/order_history_content.dart';
import 'package:project/ui/pages/search/search_content.dart';
import 'package:project/ui/shared/size_fit.dart';

class OrderHistory extends StatelessWidget {
  static final String routeName = "/orderhistory";
  const OrderHistory ({super.key});

  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize();
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders", style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 60.px)),
        centerTitle: false,
        // leading: Icon(Icons.arrow_back_ios_new),
      ),
      body: OrderHistoryContent(),
    );
  }
}