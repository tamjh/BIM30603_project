import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class buildButton extends StatelessWidget {
  const buildButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 16.h)),
          ),
          child: Text(
            "Pay",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 20.sp, color: Colors.white),
          ),
        ),
      ),
    );;
  }
}