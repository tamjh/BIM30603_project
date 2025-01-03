import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/NavigatorObserver.dart';
import 'package:project/core/viewmodel/order_view_model.dart';
import 'package:project/ui/pages/payment/buildCard.dart';
import 'package:project/ui/pages/payment/buildEwallet.dart';
import 'package:project/ui/pages/payment/buildShippingInfo.dart';
import 'package:project/ui/pages/payment/buildSubTitle.dart';
import 'package:project/ui/pages/shipping_info/shipping_info.dart';
import 'package:project/ui/pages/success/success_screen.dart';
import 'package:provider/provider.dart';

import 'PaymentControllerManager.dart';
import 'buildBottomNav.dart';

class PaymentContent extends StatefulWidget {
  const PaymentContent({super.key});

  @override
  State<PaymentContent> createState() => _PaymentContentState();
}

class _PaymentContentState extends State<PaymentContent> {
  final paymentManager = PaymentControllerManager();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  String selectedMethod = "Debit Card/Credit Card";

  final Map<String, Widget> paymentMethods = {
    // "FPX": Icon(Icons.payment),
    "Debit Card/Credit Card": Icon(Icons.credit_card),
    "Touch n Go": Icon(Icons.account_balance_wallet),
  };

  @override
  void initState() {
    super.initState();
    CurrentNavigationObserver.displayStack();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderViewModel>().fetchDefaultAddress();
    });
  }


  void handlePaymentSuccess(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessPurchasePage()),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Consumer<OrderViewModel>(
      builder: (context, orderViewModel, child) {
        if (orderViewModel.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final defaultAddress = orderViewModel.defaultAddress;
        final name = orderViewModel.userName;

        return WillPopScope(
          onWillPop: () async {
            // Handle back navigation if needed
            return true;
          },
          child: Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSubTitle(title: "Shipping Information"),
                  SizedBox(height: 20.h),
                  defaultAddress != null
                      ? BuildShippingInfo(
                    name: name,
                    onAddressChanged: () {},
                  )
                      : _buildNoAddressUI(context),
                  SizedBox(height: 20.h),
                  buildMethod(context),
                  SizedBox(height: 20.h),
                  if (selectedMethod == "Debit Card/Credit Card") buildCard(),
                  if (selectedMethod == "Touch n Go") buildEwallet(),
                ],
              ),
            ),
            bottomNavigationBar: BuildBottomNav(
              selectedMethod: selectedMethod,
              onPaymentSuccess: handlePaymentSuccess,
            ),
          ),
        );
      },
    );
  }


  Widget _buildNoAddressUI(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "No default shipping address available.",
            style: TextStyle(fontSize: 16.sp, color: Colors.red),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, ShippingInfoScreen.routeName),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 12.sp),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(100.sp),
            ),
            child: Text(
              "Set Address",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 16.sp, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMethod(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSubTitle(title: "Select Payment Method"),
        SizedBox(height: 20.h),
        DropdownButtonFormField<String>(
          value: selectedMethod,
          items: paymentMethods.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  entry.value,
                  SizedBox(width: 10.w),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(entry.key, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedMethod = newValue;

                // Clear all controllers when the payment method changes
                paymentManager.resetControllers();
              });
            }
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Payment Method",
          ),
        ),
      ],
    );
  }



  @override
  void dispose() {
    print("PaymentContent disposed");
    super.dispose();
  }
}