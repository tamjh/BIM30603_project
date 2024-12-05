import 'package:flutter/material.dart';
import 'package:project/ui/pages/home/home_content.dart';
import 'package:project/ui/shared/app_theme.dart';
import 'package:project/ui/shared/size_fit.dart';
import 'package:project/core/router/router.dart';

class HYHomeScreen extends StatelessWidget {
  static final String routeName = "/home";
  const HYHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vix Sport",
          style: HYAppTheme.normalTheme.textTheme.displayLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
        ),
        width: 500.px,
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        child: ListView(
          children: [
            SizedBox(height: 40.px),
            Center(
              child: Text(
                "My Profile",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 50.px),
              ),
            ),
            PersonalWidget(),
            DrawerContent(context, "My Order", routename: "/orderhistory"),
            DrawerContent(context, "Shipping Info", routename: "/shipping_info"),
            DrawerContent(context, "Log Out", next: false),
          ],
        ),
      ),
      body: HYHomeContent(),
    );
  }

  Widget DrawerContent(BuildContext ctx, String name,
      {bool next = true, String? routename}) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(fontSize: 48.px),
      ),
      trailing: next
          ? Icon(
              Icons.arrow_right,
              size: 60.px,
            )
          : Icon(Icons.logout),
      onTap: () {
        if (next && routename != null) {
          // Access the route directly from the HYRouter.route map
          if (HYRouter.route.containsKey(routename)) {
            Navigator.pushNamed(ctx, routename);
          } else {
            print("Route not found: $routename");
          }
        } else if (!next) {
          // Handle non-navigation actions like logout
          print("Performing non-navigation action like logout...");
        }
      },
    );
  }
}

class PersonalWidget extends StatelessWidget {
  const PersonalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DrawerHeader(
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 165, 255, 137),
            radius: 32.0,
            child: Text(
              "T",
              style: TextStyle(fontSize: 30.px, color: Colors.blue),
            ),
          ),
        ),
        Text(
          "Tam Jin Horng",
          style: TextStyle(fontSize: 32),
        ),
      ],
    );
  }
}
