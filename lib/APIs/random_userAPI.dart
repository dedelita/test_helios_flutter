import 'package:test_helios_flutter/entities/user.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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