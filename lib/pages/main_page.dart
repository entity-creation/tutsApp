import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuts_app/screens/courseView.dart';
import 'package:tuts_app/services/database.dart';

import '../models/user.dart';

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
      onPressed: () {
        close(context, null);
      },
    );
    return null;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: Icon(Icons.clear),
      color: Colors.orange,
      onPressed: () {
        if (query.isEmpty) {
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
    dynamic launcher = Provider.of<Tester?>(context);
    List<dynamic> courses = [];
    return StreamBuilder<MainUser>(
      stream: DatabaseService(uid: launcher.uid).oneUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          MainUser? data = snapshot.data;
          List courseList = data!.courses;
          if (courses.isEmpty) {
            courseList.forEach((element) {
              courses.add(element);
            });
          } else {
            courses.clear();
            courseList.forEach((element) {
              courses.add(element);
            });
          }
        }
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: MySearchDelegate());
                },
              )
            ],
          ),
          body: Center(
            child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: ((context, index) {
                  return CourseView(
                    courseName: courses[index],
                    courseDesc: "Welcome to the course",
                    uid: launcher.uid,
                  );
                })),
          ),
        ));
      },
    );
  }
}
