import 'package:flutter/material.dart';
import 'user.dart';
import 'search_page.dart';

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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _showDetails(users[index]),
                      ));
                },
                title: Text(
                  index.toString() + " " + users[index].name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(users[index].gender)),
          );
        });
  }

  _showDetails(User user) {
    final iconGender = user.gender == 'male' ? Icons.male : Icons.female;
    final colorGender = user.gender == 'male' ? Colors.blue : Colors.pink;
    return Scaffold(
        appBar: AppBar(
          title: Text(user.name),
        ),
        body: Center(
            child: Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: Column(children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(user.picture)),
                  const SizedBox(height: 10),
                  Icon(iconGender, color: colorGender),
                  Text(
                    user.name,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 15),
                  Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Column(children: [
                        Row(children: [
                          const Icon(Icons.email),
                          Text(" " + user.email)
                        ]),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.location_on),
                            Text(" " + user.address.toString())
                          ],
                        )
                      ]))
                ]))));
  }
}
