import 'package:flutter/material.dart';
import 'package:project/ui/pages/edit_address/edit_address.dart';
import 'package:project/ui/shared/size_fit.dart';

class BuildAddressBox extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const BuildAddressBox({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.px),
      padding: EdgeInsets.all(20.px),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.px),
        borderRadius: BorderRadius.circular(10.px),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address Title
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 30.px,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
          ),
          SizedBox(height: 10.px),

          // Address Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  controller.text,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 35.px,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, EditAddress.routeName);
                },
                child: Icon(Icons.edit, color: Colors.red, size: 50.px),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
