class Address {
  final String id;
  final String address;
  final String postcode;
  final String city;
  final String state;
  final bool isDefault;

  String get full => "$address, $postcode, $city, $state";

  Address({
    required this.id,
    required this.address,
    required this.postcode,
    required this.city,
    required this.state,
    required this.isDefault,
  });

  Address.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        address = map['address'],
        postcode = map['postcode'],
        city = map['city'],
        state = map['state'],
        isDefault = map['isDefault'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'postcode': postcode,
      'city': city,
      'state': state,
      'isDefault': isDefault,
    };
  }
}
