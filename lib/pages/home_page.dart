import 'package:flutter/material.dart';
import 'package:test_helios_flutter/pages/userDetailsPage.dart';
import 'package:test_helios_flutter/entities/user.dart';
import 'package:test_helios_flutter/pages/search_page.dart';
import 'package:test_helios_flutter/APIs/randomUserAPI.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = [];
  late Future<List<User>> futureUsers;

  // The controller for the ListView
  late ScrollController _controller;

  Future _loadMoreUsers() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      futureUsers = fetchUsers();
    }
  }

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
    _controller = ScrollController();
    _controller.addListener(_loadMoreUsers);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMoreUsers);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Get users"),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SearchPage(listUsers: users))),
                icon: const Icon(Icons.search))
          ],
          centerTitle: true,
        ),
        body: _buildBody(context));
  }

  // build list view & manage states
  FutureBuilder<List<User>> _buildBody(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: futureUsers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          users.addAll(snapshot.data!);
          return _buildUsers(context);
        } else {
          return const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
          );
        }
      },
    );
  }

  // build list view & its tile
  Widget _buildUsers(BuildContext context) {
    return ListView.builder(
        controller: _controller,
        key: const PageStorageKey(0),
        itemCount: users.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => UserDetailsPage(user: users[index])));
                },
                title: Text(
                  index.toString() + " " + users[index].name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(users[index].gender)),
          );
        });
  }
}
