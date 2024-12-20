import 'package:flutter/material.dart';
import 'package:project/core/model/address_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/ui/pages/edit_address/edit_address.dart';

class BuildAddressBox extends StatelessWidget {
  final Address address;
  final String label;

  const BuildAddressBox({
    super.key,
    required this.address,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        border:
            Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2.w),
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address Title
          Row(
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
              ),
              SizedBox(width: 10.w),
              if (address.isDefault)
                Card(
                  color: const Color.fromARGB(255, 236, 70, 23),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: Text(
                      'Default',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 10.h),

          // Address Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  address.full,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 25.sp,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAddress(
                          address: address,
                        ),
                      ));
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
