import 'package:flutter/material.dart';
import 'package:project/core/model/UserModel.dart';
import 'package:project/core/model/address_model.dart';
import 'package:project/core/services/auth_service.dart';

class UserViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setCurrentUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<UserModel?> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      setLoading(true);
      UserModel? user = await _authService.register(
        email: email,
        password: password,
        name: name,
      );

      setCurrentUser(user);
      return user;
    } catch (e) {
      throw Exception("Registration failed: ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      setLoading(true);
      UserModel? user =
          await _authService.login(email: email, password: password);
      setCurrentUser(user);
      return user;
    } catch (e) {
      throw Exception("Login failed: ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      setLoading(true);
      await _authService.logout();
      setCurrentUser(null);
      notifyListeners();
    } catch (e) {
      throw Exception("Logout failed: ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateName(String id, String name, BuildContext context) async {
    try {
      setLoading(true);
      await _authService.updateName(id, name);
      UserModel? user = currentUser;
      if (user != null) {
        UserModel updatedUser = user.copyWith(name: name);
        setCurrentUser(updatedUser);
        // Notify user about the successful update
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Name updated successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update name: ${e.toString()}')),
      );
    } finally {
      setLoading(false);
    }
  }

  Future<void> updatePhone(
      String id, String phone, BuildContext context) async {
    try {
      setLoading(true);
      await _authService.updatePhone(id, phone);
      UserModel? user = currentUser;
      if (user != null) {
        UserModel updatedUser = user.copyWith(phone: phone);
        setCurrentUser(updatedUser);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Phone number updated successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update phone: ${e.toString()}')),
      );
    } finally {
      setLoading(false);
    }
  }

  Future<void> addNewAddress(String uid, String address, String postcode,
      String city, String state, BuildContext context) async {
    try {
      setLoading(true);
      await _authService.addNewAddress(uid, address, postcode, city, state);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('New Address Added!')),
      );
    } catch (e) {
      throw Exception("Failed to add new address: ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateAddress(String uid, String addressId, String address, String postcode,
      String city, String state, BuildContext context) async {
    try {
      setLoading(true);
      await _authService.updateAddress(uid,addressId, address, postcode, city, state);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address Updated!')),
      );
      Navigator.pop(context);
    } catch (e) {
      throw Exception("Failed to add new address: ${e.toString()}");
    } finally {
      setLoading(false);
    }
  } 

  Future<List<Address>> getAddresses(String uid) async {
    try {
      // Use AuthService to fetch the addresses
      List<Address> addresses = await _authService.getAddresses(uid);
      return addresses;
    } catch (e) {
      print("Error in UserViewModel -> getAddresses: $e");
      throw Exception("Failed to fetch addresses: ${e.toString()}");
    }
  }

  Future<void> setDefaultAddress(String uid, String addressId) async {
    try {
      setLoading(true);
      await _authService.setDefaultAddress(uid, addressId);
    } catch (e) {
      throw Exception("Failed to set default address: ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  Future<Address?> getDefaultAddress(String uid) async {
    try {
      Address? address = await _authService.getDefaultAddress(uid);
      return address;
    } catch (e) {
      throw Exception("Failed to fetch default address: ${e.toString()}");
    }
  }
}