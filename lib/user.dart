import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final String name;
  final String gender;
  final String picture;

  const User({
    required this.name,
    required this.gender,
    required this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      User(
      name: json['name']['first'] + " " + json['name']['last'],
      gender: json['gender'],
      picture: json['picture']['medium'],
    );
}

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('https://randomuser.me/api/?inc=gender,name,picture&results=20'));
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    final res = parsed["results"];
    return res.map<User>((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Unable to fetch users');
  }
}
