import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTotal extends StatelessWidget {
  String total;
  BuildTotal({required this.total, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total amount: ",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 24.sp),
          ),
          Text(
            "RM$total",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 20.sp),
          )
        ],
      ),
    );
  }
}
