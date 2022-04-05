import 'package:flutter/material.dart';
import 'package:test_helios_flutter/entities/user.dart';

// User Details Page
class UserDetailsPage extends StatelessWidget {
  final User user;
  const UserDetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconGender = user.gender == 'male' ? Icons.male : Icons.female;
    final colorGender = user.gender == 'male' ? Colors.blue : Colors.pink;
    return Scaffold(
        appBar: AppBar(
          title: Text(user.name),
        ),
        body: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(children: <Widget>[
              SizedBox(
                height: 215,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(user.picture)),
                    Icon(iconGender, color: colorGender),
                    Text(
                      user.name,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 150,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(children: [
                          const Icon(Icons.email),
                          const SizedBox(width: 10),
                          Text(user.email,
                              style: const TextStyle(fontSize: 18)),
                        ]),
                        Row(children: [
                          const Icon(Icons.location_on),
                          const SizedBox(width: 10),
                          Flexible(
                              child: Text(user.address.toString(),
                                  style: const TextStyle(fontSize: 18)))
                        ])
                      ]))
            ])));
  }
}
