import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/core/model/UserModel.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in user with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get Firebase user
      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // Fetch additional user information from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();

        if (userDoc.exists) {
          // Create and return UserModel
          return UserModel(
            uid: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            name: userDoc['name'] ?? '',
            phone: userDoc['phone'] ?? '',
          );
        }
      }
    } catch (e) {
      print("Login Error: $e");
      throw Exception("Login failed: ${e.toString()}");
    }
    return null;
  }

  Future<UserModel?> register({
    required String email,
    required String password,
    required String name,
  }) async {
    const String phone = "";
    try {
      // Register user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'created_at': DateTime.now(),
        'phone': phone,
      });

      // Get Firebase user
      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // Create and return UserModel
        return UserModel(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          name: name,
          phone: phone ?? '',
        );
      }
    } catch (e) {
      print("Registration Error: $e");
      throw Exception("Registration failed: ${e.toString()}");
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut(); // Sign out the current user from Firebase
      print("User logged out successfully.");
    } catch (e) {
      print("Logout Error: $e");
      throw Exception("Logout failed: ${e.toString()}");
    }
  }

}
