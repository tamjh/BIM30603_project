import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/model/address_model.dart';
import 'package:project/core/viewmodel/order_view_model.dart';
import 'package:project/ui/pages/shipping_info/shipping_info.dart';
import 'package:provider/provider.dart';

class BuildShippingInfo extends StatefulWidget {
  final String name;
  final VoidCallback onAddressChanged;  // The callback for address change

  const BuildShippingInfo({
    required this.name,
    required this.onAddressChanged,  // Passing the callback
    super.key,
  });

  @override
  State<BuildShippingInfo> createState() => _BuildShippingInfoState();
}

class _BuildShippingInfoState extends State<BuildShippingInfo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderViewModel>(
      builder: (context, orderViewModel, _) {
        final defaultAddress = orderViewModel.defaultAddress;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 20.sp),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ShippingInfoScreen.routeName)
                          .then((_) => widget.onAddressChanged()); // Callback is invoked here
                    },
                    child: Text(
                      "Change",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.red,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Text(
                defaultAddress?.full ?? "Address details unavailable",
                style: TextStyle(fontSize: 20.sp),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
