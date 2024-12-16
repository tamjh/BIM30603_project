import 'package:flutter/material.dart';
import 'package:project/ui/pages/cart/cart_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CartScreen extends StatelessWidget {
  static final String routeName = "/cart";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart", style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40.sp)),
        centerTitle: true,
        // leading: IconButton(onPressed: (){
        //   Navigator.pushNamed(context, HYMainScreen.routeName);
        // }, icon: Icon(Icons.arrow_back_ios, weight: 10,)),
        automaticallyImplyLeading: false
      ),
      body: CartContent(),
    );
  }
}