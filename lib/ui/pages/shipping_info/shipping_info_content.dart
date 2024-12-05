import 'package:flutter/material.dart';
import 'package:project/ui/pages/shipping_info/account_content.dart';
import 'package:project/ui/pages/shipping_info/address_content.dart';
import 'package:project/ui/pages/shipping_info/subtitle.dart';
import 'package:project/ui/shared/size_fit.dart';

class ShippingInfoContent extends StatefulWidget {
  const ShippingInfoContent({super.key});

  @override
  State<ShippingInfoContent> createState() => _ShippingInfoContentState();
}

class _ShippingInfoContentState extends State<ShippingInfoContent> {
  final TextEditingController _nameController =
      TextEditingController(text: "XXX XXXXXXXXXXX");
  final TextEditingController _phoneController =
      TextEditingController(text: "014-123456789");

  // List to hold delivery addresses
  List<TextEditingController> _addressControllers = [
    TextEditingController(text: "21, jalan indah, 12/5 taman bukit indah"),
    TextEditingController(text: "456 Avenue, City, Country"),
    TextEditingController(text: "789 Boulevard, City, Country"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.px),
      children: [
        const BuildSubTitle(title: "Account Settings"),
        BuildAccountBox(
            nameController: _nameController, phoneController: _phoneController),
        SizedBox(height: 50.px),
        const BuildSubTitle(title: "Delivery Address"),
        ...List.generate(
          _addressControllers.length,
          (index) {
            return BuildAddressBox(
              label: "Address ${index + 1}",
              controller: _addressControllers[index],
              
            );
          },
        ),
        SizedBox(height: 20.px),
        ElevatedButton.icon(
          onPressed: () {          },
          icon: const Icon(Icons.add),
          label: const Text("Add New Address"),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red), foregroundColor: MaterialStateProperty.all(Colors.white)),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    for (var controller in _addressControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}



