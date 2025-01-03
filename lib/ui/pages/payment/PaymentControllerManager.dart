import 'package:flutter/material.dart';

class PaymentControllerManager {
  static final PaymentControllerManager _instance =
  PaymentControllerManager._internal();

  factory PaymentControllerManager() {
    return _instance;
  }

  PaymentControllerManager._internal();

  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController expDate = TextEditingController();
  final TextEditingController cvv = TextEditingController();
  final TextEditingController phone = TextEditingController();

  void resetControllers() {
    cardNumber.clear();
    expDate.clear();
    cvv.clear();
    phone.clear();
  }

  void dispose() {
    cardNumber.dispose();
    expDate.dispose();
    cvv.dispose();
    phone.dispose();
  }
}
