import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/ui/pages/payment/pay_button.dart';

class buildBottomNav extends StatelessWidget {
  const buildBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Price Summary Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order:",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  Text("RM 123.00", style: TextStyle(fontSize: 16.sp),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery:",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  Text("RM 12.00", style: TextStyle(fontSize: 16.sp)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  Text("RM 135.00", style: TextStyle(fontSize: 20.sp)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        buildButton(),
      ],
    );
  }
}