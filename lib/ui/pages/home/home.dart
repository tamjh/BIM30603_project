import 'package:flutter/material.dart';
import 'package:project/ui/pages/home/home_content.dart';
import 'package:project/ui/shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/ui/shared/drawer/drawer.dart';

class HYHomeScreen extends StatelessWidget {
  static final String routeName = "/home";
  const HYHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          child: Image.asset("assets/images/word_logo.png", height: 30.sp,)
        ),
      ),
      drawer: DrawerDisplay(),
      body: HYHomeContent(),
    );
  }
}
