import 'package:flutter/material.dart';


class MySearchDelegate extends SearchDelegate {

  List<String> searchResults = [
    "Student",
    "Teacher",
    "Admin",
  ];

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        icon: Icon(Icons.arrow_back),
      color: Colors.orange,
      onPressed: () {close(context, null);},
    );
    return null;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: Icon(Icons.clear),
      color: Colors.orange,
      onPressed: () {
        if(query.isEmpty) {
          close(context, null);
        }
        query = '';
      },
    );
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: TextStyle(fontSize: 40),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searching) {
      final result = searching.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();
    return ListView.builder(
      itemCount: suggestions.length,
        itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
        });
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: MySearchDelegate());
                },
              )
            ],
          ),
          body: Center(
            child: Text(
              "Home",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ));
  }
}
