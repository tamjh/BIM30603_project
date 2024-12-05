import 'package:flutter/material.dart';
import 'package:project/ui/pages/register/register_content.dart';

class HYRegister extends StatelessWidget {
  static const String routeName = "/register";
  const HYRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HYRegisterContent(),
    );
  }
}
