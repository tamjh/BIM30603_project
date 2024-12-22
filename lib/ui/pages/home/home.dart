import 'package:flutter/material.dart';
import 'package:project/core/viewmodel/user_view_model.dart';
import 'package:project/ui/pages/home/home_content.dart';
import 'package:project/ui/shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/ui/shared/drawer/drawer.dart';
import 'package:provider/provider.dart';

class HYHomeScreen extends StatelessWidget {
  static final String routeName = "/home";
  const HYHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "Vix Sport",
            style: HYAppTheme.normalTheme.textTheme.displayLarge
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 32.h),
          ),
        ),
      ),
      drawer: DrawerDisplay(),
      body: HYHomeContent(),
    );
  }
}
