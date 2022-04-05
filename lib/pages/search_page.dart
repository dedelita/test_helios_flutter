import 'package:flutter/material.dart';
import 'package:test_helios_flutter/entities/user.dart';
import 'user_details_page.dart';

// Search Page
class SearchPage extends StatefulWidget {
  final List<User> listUsers;

  const SearchPage({Key? key, required this.listUsers}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // This list holds the data for the list view
  List<User> _foundUsers = [];
  final TextEditingController _textEditingController = TextEditingController();
  @override
  initState() {
    // at the beginning, all users are shown
    super.initState();
  }

// This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<User> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = widget.listUsers;
    } else {
      results = widget.listUsers
          .where((user) =>
              user.name.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              (user.gender == enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              controller: _textEditingController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      /* Clear the search field */
                      _textEditingController.clear();
                    },
                  ),
                  hintText: 'Recherche...',
                  border: InputBorder.none),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Expanded(
                child: _foundUsers.isNotEmpty
                    ? ListView.builder(
                        itemCount: _foundUsers.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(index),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => UserDetailsPage(
                                      user: _foundUsers[index])));
                            },
                            title: Text(_foundUsers[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(_foundUsers[index].gender),
                          ),
                        ),
                      )
                    : const Text(
                        'Aucun résultat',
                        style: TextStyle(fontSize: 24),
                      ),
              ),
            ])));
  }
}
