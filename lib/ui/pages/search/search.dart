import 'package:flutter/material.dart';
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

      ),
      body: SearchContent(),
    );
  }
}