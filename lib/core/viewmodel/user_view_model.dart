import 'package:flutter/material.dart';
import 'package:project/core/model/UserModel.dart';
import 'package:project/core/services/auth_service.dart';
import 'package:project/ui/widgets/errorMsg.dart';

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
        SnackbarUtils.showMsg(context, "Updated Successful");
        ;
      }
    } catch (e) {
      SnackbarUtils.showMsg(context, "Failed to Update Name");
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

        SnackbarUtils.showMsg(context, "Phone number updated successfully");
      }
    } catch (e) {
      SnackbarUtils.showMsg(context, "Failed to update phone");
    } finally {
      setLoading(false);
    }
  }
}
