import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/core/model/address_model.dart';

class AddressService{
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<void> addNewAddress(String uid, String address, String postcode,
      String city, String state, bool isDefault) async {
    try {
      DocumentReference docRef = _firestore.collection('users').doc(uid);
      CollectionReference addressRef = docRef.collection('addresses');

      // Create a new address document
      final Map<String, dynamic> newAddress = {
        'address': address,
        'postcode': postcode,
        'city': city,
        'state': state,
        'isDefault': isDefault
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

  Future<void> deleteAddress(String uid, String addressId) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('addresses')
        .doc(addressId)
        .delete();
  }
}