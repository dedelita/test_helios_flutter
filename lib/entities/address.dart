class Address {
  final String street;
  final String city;
  final String state;
  final String country;
  final String postcode;

  const Address ({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode
});
  
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street:json['street']['number'].toString() + " " + json['street']['name'],
      city:json['city'],
      state:json['state'],
      country:json['country'],
      postcode:json['postcode'].toString(),
    );
  }

  @override
  String toString() {
    return '$street, $city \n $state, $postcode \n $country';
  }
}