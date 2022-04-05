import 'address.dart';

class User {
  final String name;
  final String gender;
  final String picture;
  final String email;
  final Address address;

  const User({
    required this.name,
    required this.gender,
    required this.picture,
    required this.email,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      User(
        name: json['name']['first'] + ' ' + json['name']['last'],
        gender: json['gender'],
        picture: json['picture']['large'],
        email: json['email'],
        address: Address.fromJson(json['location']),
    );
}
