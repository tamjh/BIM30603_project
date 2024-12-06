import 'package:flutter/material.dart';
import 'package:project/ui/pages/shop/shop_content.dart';
import 'package:project/ui/shared/size_fit.dart';

class ShopScreen extends StatelessWidget {
  static final String routeName = "/shop";
  const ShopScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize();
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop", style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 60.px)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){}, icon: Icon(Icons.search, size: 64.px,))
          ),
        ],
      ),
      body: ShopContent(),
    );
  }
}