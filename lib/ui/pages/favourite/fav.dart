import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/ui/shared/drawer/drawer.dart';

import 'fav_content.dart';

class FavouriteScreen extends StatelessWidget {
  static final String routeName = "/favourite";

  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Item",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 32.sp)),
        centerTitle: true,
      ),
      drawer: DrawerDisplay(),
      body: FavContent(),
    );
  }
}
