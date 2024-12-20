class UserModel {
  final String uid;
  final String email;
  final String name;
  final String phone;

  UserModel({required this.uid, required this.email, required this.name, required this.phone});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      uid: documentId,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? phone,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
