import 'package:flutter/material.dart';
import 'package:project/ui/pages/search/search.dart';
import 'package:project/ui/pages/shop/shop_content.dart';
import 'package:project/ui/shared/drawer/drawer.dart';
import 'package:project/ui/shared/size_fit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopScreen extends StatelessWidget {
  static final String routeName = "/shop";
  const ShopScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize();
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
            child: Image.asset("assets/images/word_logo.png", height: 30.sp,)
        ),        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){
              Navigator.pushNamed(context, SearchScreen.routeName);
            }, icon: Icon(Icons.search, size: 32.sp,))
          ),
        ],
      ),
      drawer: DrawerDisplay(),
      body: ShopContent(),
    );
  }
}