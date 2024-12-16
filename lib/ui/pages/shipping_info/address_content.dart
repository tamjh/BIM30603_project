import 'package:flutter/material.dart';
import 'package:project/ui/pages/edit_address/edit_address.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildAddressBox extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const BuildAddressBox({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.w),
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address Title
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
          ),
          SizedBox(height: 10.h),

          // Address Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  controller.text,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 25.sp,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, EditAddress.routeName);
                },
                child: Icon(Icons.edit, color: Colors.red, size: 25.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
