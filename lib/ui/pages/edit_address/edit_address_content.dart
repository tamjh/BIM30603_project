import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/model/address_model.dart';
import 'package:project/core/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class EditAddressContent extends StatefulWidget {
  const EditAddressContent({super.key, this.address});
  final Address? address;

  @override
  State<EditAddressContent> createState() => _EditAddressContentState();
}

class _EditAddressContentState extends State<EditAddressContent> {
  late TextEditingController addressController;
  late TextEditingController postcodeController;
  late TextEditingController cityController;
  late TextEditingController statesController;
  UserViewModel? _userViewModel;
  String? uid;

  bool isDefault = false;

  @override
  void initState() {
    super.initState();

    // Ensure controllers are initialized
    addressController = TextEditingController(
      text: widget.address?.address ?? '',
    );
    postcodeController = TextEditingController(
      text: widget.address?.postcode ?? '',
    );
    cityController = TextEditingController(
      text: widget.address?.city ?? '',
    );
    statesController = TextEditingController(
      text: widget.address?.state ?? '',
    );

    // Get the current user
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    uid = _userViewModel?.currentUser?.uid;

    // Initialize text fields if address is not null
    if (widget.address != null) {
      addressController.text = widget.address!.address;
      postcodeController.text = widget.address!.postcode;
      cityController.text = widget.address!.city;
      statesController.text = widget.address!.state;
    }

        if (widget.address != null) {
      isDefault = widget.address!.isDefault;
    }
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    addressController.dispose();
    postcodeController.dispose();
    cityController.dispose();
    statesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0.sp),
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
                style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 24.sp) ??
                    TextStyle(fontSize: 16.sp), // Fallback style
              ),
              hintText: "House No, Unit No, Street",
            ),
          ),
          SizedBox(height: 15.h),

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
                      style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(fontSize: 24.sp) ??
                          TextStyle(fontSize: 16.sp), // Fallback style
                    ),
                    hintText: "Insert the delivery postcode",
                  ),
                ),
              ),
              SizedBox(width: 10.sp),
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "City",
                      style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(fontSize: 24.sp) ??
                          TextStyle(fontSize: 8.sp), // Fallback style
                    ),
                    hintText: "Insert the delivery city",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.sp),

          // State Field
          TextFormField(
            controller: statesController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text(
                "State",
                style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 24.sp) ??
                    TextStyle(fontSize: 16.sp), // Fallback style
              ),
              hintText: "Insert the delivery state",
            ),
          ),
          SizedBox(height: 15.sp),

          // Default Address Checkbox
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Save as default address",
                style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 16.sp) ??
                    TextStyle(fontSize: 16.sp), // Fallback style
              ),
              SizedBox(width: 8.sp),
              Checkbox(
                value: isDefault,
                onChanged: (value) {
                  setState(() {
                    isDefault = value!;  // Update the checkbox state
                  });
                },
              ),
            ],
          ),

          SizedBox(
            height: 20.h,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (widget.address != null) {
                    _userViewModel?.updateAddress(
                      uid!,
                      widget.address!.id,
                      addressController.text,
                      postcodeController.text,
                      cityController.text,
                      statesController.text,
                      context,
                    );
                  } else {
                    _userViewModel?.addNewAddress(
                      uid!,
                      addressController.text,
                      postcodeController.text,
                      cityController.text,
                      statesController.text,
                      context,
                    );
                  }

                  // Set default address if the checkbox is selected
                  if (isDefault && widget.address != null) {
                    _userViewModel?.setDefaultAddress(uid!, widget.address!.id);
                    
                  } else {
                    
                  }

                  Navigator.pop(context, true);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 30.sp),
                )),
          ),
        ],
      ),
    );
  }
}
