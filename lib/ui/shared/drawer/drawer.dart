import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/router/router.dart';
import 'package:project/core/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class DrawerDisplay extends StatelessWidget {
  DrawerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, viewModel, child) {
      return Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)),
          ),
          width: 300.w,
          backgroundColor: const Color.fromARGB(255, 230, 230, 230),
          child: ListView(
            children: [
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  "My Profile",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 30.sp),
                ),
              ),
              PersonalWidget(viewModel: viewModel),
              DrawerContent(context, "My Order",
                  routename: "/orderhistory", viewModel: null),
              DrawerContent(context, "Shipping Info",
                  routename: "/shipping_info", viewModel: null),
              DrawerContent(context, "Log Out",
                  next: false, viewModel: viewModel),
            ],
          ));
    });
  }

  Widget DrawerContent(BuildContext ctx, String name,
      {bool next = true, String? routename, UserViewModel? viewModel}) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(fontSize: 30.sp),
      ),
      trailing: next
          ? Icon(
              Icons.arrow_right,
              size: 30.sp,
            )
          : Icon(Icons.logout),
      onTap: () async {
        if (next && routename != null) {
          // Access the route directly from the HYRouter.route map
          if (HYRouter.route.containsKey(routename)) {
            Navigator.pushNamed(ctx, routename);
          } else {
            print("Route not found: $routename");
          }
        } else if (!next && viewModel != null) {
          // Handle non-navigation actions like logout
          await viewModel.logout();
          print("Performing non-navigation action like logout...");
          Navigator.pushReplacementNamed(ctx, '/login');
        }
      },
    );
  }
}

class PersonalWidget extends StatelessWidget {
  final UserViewModel viewModel;

  const PersonalWidget({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DrawerHeader(
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 165, 255, 137),
            radius: 24.w,
            child: Text(
              viewModel.currentUser?.name[0] ?? '',
              style: TextStyle(fontSize: 30.sp, color: Colors.blue),
            ),
          ),
        ),
        Text(
          viewModel.currentUser?.name ?? 'Guest',
          style: TextStyle(fontSize: 25.sp),
        ),
      ],
    );
  }
}
