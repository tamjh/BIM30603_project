import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/model/address_model.dart';
import 'package:project/core/viewmodel/address_view_model.dart';
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
  AddressViewModel? _addressViewModel;
  String? uid;

  bool isDefault = false;

  @override
  void initState() {
    super.initState();

    // Get the AddressViewModel from the context
    _addressViewModel = Provider.of<AddressViewModel>(context, listen: false);

    // Initialize controllers and other setup code...
    addressController = TextEditingController(text: widget.address?.address ?? '');
    postcodeController = TextEditingController(text: widget.address?.postcode ?? '');
    cityController = TextEditingController(text: widget.address?.city ?? '');
    statesController = TextEditingController(text: widget.address?.state ?? '');

    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    uid = _userViewModel?.currentUser?.uid;

    if (widget.address != null) {
      isDefault = widget.address!.isDefault;
    }
  }

  // Helper method to refresh addresses and navigate back
  Future<void> _handleAddressOperation(Future<void> Function() operation) async {
    try {
      await operation();
      if (uid != null) {
        // Refresh the addresses list
        await _addressViewModel?.getAddresses(uid!);
        if (mounted) {
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Operation failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Padding(
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
                          isDefault = value!; // Update the checkbox state
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
                      onPressed: () async {
                        if (uid == null) return;

                        if (widget.address != null) {
                          await _handleAddressOperation(() async {
                            await _addressViewModel?.updateAddress(
                              uid!,
                              widget.address!.id,
                              addressController.text,
                              postcodeController.text,
                              cityController.text,
                              statesController.text,
                              context,
                            );

                            if (isDefault) {
                              await _addressViewModel?.setDefaultAddress(uid!, widget.address!.id);
                            }
                          });
                        } else {
                          await _handleAddressOperation(() async {
                            await _addressViewModel?.addNewAddress(
                              uid!,
                              addressController.text,
                              postcodeController.text,
                              cityController.text,
                              statesController.text,
                              isDefault,
                              context,
                            );
                          });
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red)
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 30.sp),
                      )
                  ),
                ),

                SizedBox(height: 10.sp),

                if (widget.address != null)
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.red)
                        ),
                        onPressed: () async {
                          if (uid == null) return;

                          await _handleAddressOperation(() async {
                            await _addressViewModel?.deleteAddress(
                              uid!,
                              widget.address!.id,
                              context,
                            );
                          });
                        },
                        child: Text(
                            "Delete Address",
                            style: TextStyle(color: Colors.white, fontSize: 30.sp)
                        )
                    ),
                  ),
              ],
            ),
          ),
        ]
    );
  }
}