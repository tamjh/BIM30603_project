import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildSubTitle extends StatelessWidget {
  final String title;
  const BuildSubTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}