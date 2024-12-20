import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/core/model/UserModel.dart';
import 'package:project/core/model/address_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  Future<void> updateName(String uid, String name) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'name': name,
      });
      print("Name updated successfully.");
    } catch (e) {
      print("Update Name Error: $e");
      throw Exception("Update Name failed: ${e.toString()}");
    }
  }

  Future<void> updatePhone(String uid, String phone) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'phone': phone,
      });
      print("Name updated successfully.");
    } catch (e) {
      print("Update Name Error: $e");
      throw Exception("Update Name failed: ${e.toString()}");
    }
  }

  Future<void> addNewAddress(String uid, String address, String postcode,
      String city, String state) async {
    try {
      DocumentReference docRef = _firestore.collection('users').doc(uid);
      CollectionReference addressRef = docRef.collection('addresses');

      // Create a new address document
      final Map<String, dynamic> newAddress = {
        'address': address,
        'postcode': postcode,
        'city': city,
        'state': state,
      };

      await addressRef.add(newAddress);
    } catch (e) {
      print("Update Address Error: $e");
      throw Exception("Update Address failed: ${e.toString()}");
    }
  }

  Future<void> updateAddress(String uid, String addressId, String address,
      String postcode, String city, String state) async {
    try {
      DocumentReference docRef = _firestore.collection('users').doc(uid);
      CollectionReference addressRef = docRef.collection('addresses');

      final Map<String, dynamic> newAddress = {
        'address': address,
        'postcode': postcode,
        'city': city,
        'state': state,
        'isDefault': false,
      };

      await addressRef.doc(addressId).update(newAddress);
    } catch (e) {
      print("Update Address Error: $e");
      throw Exception("Update Address failed: ${e.toString()}");
    }
  }

  Future<List<Address>> getAddresses(String uid) async {
    try {
      // Reference to the user's document and addresses subcollection
      DocumentReference docRef = _firestore.collection('users').doc(uid);
      CollectionReference addressRef = docRef.collection('addresses');

      // Retrieve all address documents
      QuerySnapshot querySnapshot = await addressRef.get();

      // Map each document to an Address model
      List<Address> addresses = querySnapshot.docs.map((doc) {
        return Address(
          id: doc.id,
          address: doc['address'],
          postcode: doc['postcode'],
          city: doc['city'],
          state: doc['state'],
          isDefault: doc['isDefault'],
        );
      }).toList();

      return addresses;
    } catch (e) {
      print("Get Addresses Error: $e");
      throw Exception("Get Addresses failed: ${e.toString()}");
    }
  }

  Future<void> setDefaultAddress(String userId, String addressId) async {
    // First, set all addresses to non-default
    final addressDocs = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .get();

    WriteBatch batch = FirebaseFirestore.instance.batch();

    // Set all addresses to non-default
    for (var doc in addressDocs.docs) {
      batch.update(doc.reference, {'isDefault': false});
    }

    // Set the selected address as default
    batch.update(
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('addresses')
            .doc(addressId),
        {'isDefault': true});

    await batch.commit();
  }

  Future<Address?> getDefaultAddress(String userId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .where('isDefault', isEqualTo: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) return null;

    final doc = querySnapshot.docs.first;
    return Address(
      id: doc.id,
      address: doc['address'],
      postcode: doc['postcode'],
      city: doc['city'],
      state: doc['state'],
      isDefault: doc['isDefault'],
      
    );
  }
}
