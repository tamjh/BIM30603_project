import 'package:flutter/material.dart';
import 'package:project/ui/pages/edit_address/edit_address_content.dart';
import 'package:project/ui/shared/size_fit.dart';

class EditAddress extends StatelessWidget {
  static final String routeName = "/edit_address";
  const EditAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Address",
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(fontSize: 60.px),
        ),
      ),
      body: EditAddressContent(),
    );
  }
}
