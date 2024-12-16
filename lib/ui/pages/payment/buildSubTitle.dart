import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class buildSubTitle extends StatelessWidget {
  final String title;
  buildSubTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Text(
        title,
        style:
            Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30.sp),
      ),
    );
    ;
  }
}
