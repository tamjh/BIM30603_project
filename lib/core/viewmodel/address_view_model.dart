import 'package:flutter/material.dart';
import 'package:project/core/services/address_service.dart';
import 'package:project/core/model/address_model.dart';

class AddressViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Address> _addresses = [];

  List<Address> get addresses => _addresses;

  final AddressService _addressService = AddressService();

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> addNewAddress(String uid, String address, String postcode,
      String city, String state, bool isDefault, BuildContext context) async {
    try {
      setLoading(true);
      await _addressService.addNewAddress(
          uid, address, postcode, city, state, isDefault);
      await getAddresses(uid); // Refresh the address list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add address: $e')),
      );
      rethrow; // Rethrow to handle in the UI
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateAddress(String uid, String addressId, String address,
      String postcode, String city, String state, BuildContext context) async {
    try {
      setLoading(true);
      await _addressService.updateAddress(
          uid, addressId, address, postcode, city, state);
      await getAddresses(uid); // Refresh the address list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update address: $e')),
      );
      rethrow; // Rethrow to handle in the UI
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteAddress(
      String uid, String addressId, BuildContext ctx) async {
    try {
      setLoading(true);
      await _addressService.deleteAddress(uid, addressId);
      await getAddresses(uid); // Refresh the address list
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text('Address Deleted!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Failed to delete address: $e')),
      );
      rethrow; // Rethrow to handle in the UI
    } finally {
      setLoading(false);
    }
  }

  Future<List<Address>> getAddresses(String uid) async {
    try {
      setLoading(true);
      List<Address> addresses = await _addressService.getAddresses(uid);
      _addresses = addresses; // Update the address list
      notifyListeners();
      return addresses;
    } catch (e) {
      throw Exception("Failed to fetch addresses: ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  Future<void> setDefaultAddress(String uid, String addressId) async {
    try {
      setLoading(true);
      await _addressService.setDefaultAddress(uid, addressId);
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to set default address: ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  Future<Address?> getDefaultAddress(String uid) async {
    try {
      Address? address = await _addressService.getDefaultAddress(uid);
      return address;
    } catch (e) {
      throw Exception("Failed to fetch default address: ${e.toString()}");
    }
  }
}
