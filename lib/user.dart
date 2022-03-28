import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final String name;
  final String gender;
  final String picture;
  final String email;
  final String address;

  const User({
    required this.name,
    required this.gender,
    required this.picture,
    required this.email,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      User(
        name: json['name']['first'] + " " + json['name']['last'],
        gender: json['gender'],
        picture: json['picture']['large'],
        email: json['email'],
        address: json['location']['street'] + ' ' + json['location']['city'] + ' '  + json['location']['state'] + ' ' + json['location']['postcode']
    );
}

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('https://randomuser.me/api/?inc=gender,name,picture,email,location&results=20'));
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    final res = parsed["results"];
    return res.map<User>((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Unable to fetch users');
  }
}
