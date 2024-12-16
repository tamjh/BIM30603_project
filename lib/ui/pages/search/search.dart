import 'package:flutter/material.dart';
import 'package:project/ui/pages/main/main.dart';
import 'package:project/ui/pages/search/search_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  static final String routeName = "/search";
  const SearchScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40.sp)),
        centerTitle: true,
        automaticallyImplyLeading: false
        // leading: IconButton(onPressed: (){
        //   Navigator.pushNamed(context, HYMainScreen.routeName);
        // }, icon: Icon(Icons.arrow_back_ios, weight: 10,)),
      ),
      body: SearchContent(),
    );
  }
}