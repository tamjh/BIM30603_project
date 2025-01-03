import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:project/core/viewmodel/order_view_model.dart';
import 'package:project/ui/pages/payment/pay_button.dart';

class BuildBottomNav extends StatelessWidget {
  final String selectedMethod;
  final Function(BuildContext) onPaymentSuccess;

  const BuildBottomNav({
    super.key,
    required this.selectedMethod,
    required this.onPaymentSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderViewModel>(
      builder: (context, orderViewModel, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PriceSummary(
                orderPrice: orderViewModel.orderPrice,
                deliveryFee: 12.00,
                totalPrice: orderViewModel.totalPrice,
              ),
              SizedBox(height: 5.h),
              BuildButton(
                selectedMethod: selectedMethod,
                onPaymentSuccess: onPaymentSuccess,
              ),
            ],
          ),
        );
      },
    );
  }
}

class PriceSummary extends StatelessWidget {
  final double orderPrice;
  final double deliveryFee;
  final double totalPrice;

  const PriceSummary({
    super.key,
    required this.orderPrice,
    required this.deliveryFee,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPriceRow(context, "Order:", "RM ${orderPrice.toStringAsFixed(2)}"),
        _buildPriceRow(context, "Delivery:", "RM ${deliveryFee.toStringAsFixed(2)}"),
        _buildPriceRow(
          context,
          "Total:",
          "RM ${totalPrice.toStringAsFixed(2)}",
          isBold: true,
        ),
      ],
    );
  }

  Widget _buildPriceRow(BuildContext context, String label, String value,
      {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: Colors.grey, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
        Text(value, style: TextStyle(fontSize: isBold ? 20.sp : 16.sp)),
      ],
    );
  }
}
