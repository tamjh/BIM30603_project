import 'package:flutter/material.dart';
import 'package:project/ui/shared/size_fit.dart';

class EditAddressContent extends StatefulWidget {
  const EditAddressContent({super.key});

  @override
  State<EditAddressContent> createState() => _EditAddressContentState();
}

class _EditAddressContentState extends State<EditAddressContent> {
  TextEditingController addressController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController statesController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    postcodeController.dispose();
    cityController.dispose();
    statesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address Field
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text(
                "Address",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              hintText: "House No, Unit No, Street",
            ),
          ),
          const SizedBox(height: 15.0),

          // Postcode and City Fields
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: postcodeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "Postcode",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    hintText: "Insert the delivery postcode",
                  ),
                ),
              ),
              const SizedBox(width: 10.0), // Space between fields
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "City",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    hintText: "Insert the delivery city",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),

          // State Field
          TextFormField(
            controller: statesController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text(
                "State",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              hintText: "Insert the delivery state",
            ),
          ),
          SizedBox(
            height: 40.px,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
