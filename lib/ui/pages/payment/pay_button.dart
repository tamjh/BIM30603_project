import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/viewmodel/order_view_model.dart';
import 'package:project/main.dart';
import 'package:project/ui/pages/success/success_screen.dart';
import 'package:project/ui/widgets/errorMsg.dart';
import 'package:provider/provider.dart';

import 'PaymentControllerManager.dart';

class BuildButton extends StatefulWidget {
  final String selectedMethod;
  final Function(BuildContext) onPaymentSuccess;

  const BuildButton({
    super.key,
    required this.selectedMethod,
    required this.onPaymentSuccess,
  });

  @override
  State<BuildButton> createState() => _BuildButtonState();
}

class _BuildButtonState extends State<BuildButton> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderViewModel>(
      builder: (context, orderViewModel, _) {
        return Padding(
          padding: EdgeInsets.all(16.sp),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (_isProcessing || orderViewModel.isLoading)
                  ? null
                  : () => _handlePayment(context, orderViewModel),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  (_isProcessing || orderViewModel.isLoading)
                      ? Colors.grey
                      : Colors.red,
                ),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 16.h),
                ),
              ),
              child: (_isProcessing || orderViewModel.isLoading)
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                      "Pay",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(fontSize: 20.sp, color: Colors.white),
                    ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _handlePayment(
      BuildContext context, OrderViewModel orderViewModel) async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final paymentManager = PaymentControllerManager();
      Map<String, dynamic> paymentContent = {};

      // Validate payment details
      if (widget.selectedMethod == "Debit Card/Credit Card") {
        if (paymentManager.cardNumber.text.isEmpty ||
            paymentManager.expDate.text.isEmpty ||
            paymentManager.cvv.text.isEmpty) {
          SnackbarUtils.showMsg(context, "Please fill in all card details");
          return;
        }
        paymentContent = {
          'cardNumber': paymentManager.cardNumber.text,
          'expDate': paymentManager.expDate.text,
          'cvv': paymentManager.cvv.text,
        };
      } else if (widget.selectedMethod == "Touch n Go") {
        if (paymentManager.phone.text.isEmpty) {
          SnackbarUtils.showMsg(context, "Please enter phone number");
          return;
        }
        paymentContent = {
          'phoneNumber': paymentManager.phone.text,
        };
      }

      print("Processing payment at ${DateTime.now()}");

      // Process payment
      List res = await orderViewModel.placeOrder(widget.selectedMethod, paymentContent);

      // Use the global navigatorKey to navigate
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState?.pushNamed(
          SuccessPurchasePage.routeName,
          arguments: res
        );
      });
    } catch (e) {
      SnackbarUtils.showMsg(context, "Payment failed: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }
}
