import 'package:flutter/material.dart';
import 'login_content.dart';

class HYLogin extends StatelessWidget {
  static final String routeName = "/login";
  const HYLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HYLoginContent()
    );
  }
}
