import 'package:flutter/material.dart';
import 'package:project/core/viewmodel/index_view_model.dart';
import 'package:project/ui/pages/cart/cart_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/ui/shared/drawer/drawer.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static final String routeName = "/cart";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int currentIndex = 0;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40.sp),
        ),
        centerTitle: true,
      ),
      drawer: DrawerDisplay(),
      body: CartContent(),
    );
  }
}
