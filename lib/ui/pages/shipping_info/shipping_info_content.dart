import 'package:flutter/material.dart';
import 'package:project/core/model/UserModel.dart';
import 'package:project/core/model/address_model.dart';
import 'package:project/core/viewmodel/address_view_model.dart';
import 'package:project/core/viewmodel/user_view_model.dart';
import 'package:project/ui/pages/edit_address/edit_address.dart';
import 'package:project/ui/pages/shipping_info/account_content.dart';
import 'package:project/ui/pages/shipping_info/address_content.dart';
import 'package:project/ui/pages/shipping_info/subtitle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ShippingInfoContent extends StatefulWidget {
  const ShippingInfoContent({super.key});

  @override
  State<ShippingInfoContent> createState() => _ShippingInfoContentState();
}

class _ShippingInfoContentState extends State<ShippingInfoContent> {
  UserViewModel? _userViewModel;
  AddressViewModel? _addressViewModel;
  UserModel? _user;
  String? uid;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    _addressViewModel = Provider.of<AddressViewModel>(context, listen: false);
    _user = _userViewModel?.currentUser;
    uid = _user?.uid;

    if (_user != null) {
      _nameController.text = _user!.name;
      _phoneController.text = _user!.phone;
    }

    // Use addPostFrameCallback to fetch addresses after the initial build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (uid != null) {
        _addressViewModel!.getAddresses(uid!);
      }
    });
  }

  void _refreshAddresses() {
    if (uid != null) {
      _addressViewModel?.getAddresses(uid!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressViewModel>(
      builder: (context, addressViewModel, _) {
        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20.w),
                children: [
                  const BuildSubTitle(title: "Account Settings"),
                  BuildAccountBox(
                    nameController: _nameController,
                    phoneController: _phoneController,
                    uid: uid ?? "",
                  ),
                  SizedBox(height: 50.h),
                  const BuildSubTitle(title: "Delivery Address"),
                  addressViewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : addressViewModel.addresses.isEmpty
                      ? const Center(child: Text("No addresses found."))
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: addressViewModel.addresses.length,
                    itemBuilder: (context, index) {
                      return BuildAddressBox(
                        address: addressViewModel.addresses[index],
                        label: "Address ${index + 1}",
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: buildNewBtn(context),
            ),
          ],
        );
      },
    );
  }

  ElevatedButton buildNewBtn(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditAddress(address: null),
          ),
        ).then((result) {
          if (result == true) {
            _refreshAddresses();
          }
        });
      },
      icon: const Icon(Icons.add),
      label: Text("Add New Address", style: TextStyle(fontSize: 36.sp)),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            const Color.fromARGB(255, 248, 48, 17)),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}