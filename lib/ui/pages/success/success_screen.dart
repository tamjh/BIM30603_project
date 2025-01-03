import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/ui/pages/main/main.dart';
import 'package:provider/provider.dart';
import '../../../core/NavigatorObserver.dart';
import '../../../core/viewmodel/index_view_model.dart';

class SuccessPurchasePage extends StatelessWidget {

  static String routeName = "/success";

  const SuccessPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    int globalArgument = 0;

    print("*****************************************");
    CurrentNavigationObserver.displayStack();
    print("*****************************************");
    print("print at success page");
    final args = ModalRoute.of(context)?.settings.arguments as List?;
    final String name = args?[0] ?? "Unknown";
    final double totalPrice = (args?[1]?.toDouble()+12.00) ?? 0.0;
    final String address = args?[2] ?? "Not provided";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 16),
            const Text(
              'Thank you for your purchase!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your order has been placed successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Thank You $name !",
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total Price: RM ${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Address: $address',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white)
              ),
              onPressed: () {
                context.read<NavigationViewModel>().setArgument(1);
                // Ensure that navigation occurs after the frame is rendered
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  globalArgument = 1;
                  // Pop the pages until reaching the CartScreen route
                  Navigator.of(context).popUntil((route) {
                    print('Route: ${route.settings.name}');
                    return route.settings.name == HYMainScreen.routeName; // Navigate to CartScreen
                  });
                  // After popping the routes, we can update the navigation view model
                });
              },
              child: const Text('Back to Home'),
            ),



          ],
        ),
      ),
    );
  }
}
