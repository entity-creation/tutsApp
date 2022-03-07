import 'package:flutter/material.dart';
import 'package:tuts_app/models/info.dart';
import 'package:tuts_app/models/user.dart';
import 'package:tuts_app/pages/profile_page.dart';
import 'package:tuts_app/pages/main_page.dart';
import 'package:tuts_app/services/database.dart';
import 'package:provider/provider.dart';
import '../chat_page.dart';

class Home extends StatefulWidget {

  final String uid;
  const Home({Key? key, required this.uid}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int indexing = 0;

  dynamic screens = [
    MainPage(),
    ChatPage(user: MainUser(name: '',
        lastMessageTime: null,
        urlAvatar: '', number: '',
        gender: 0, address: '',
        uid: '', function: 0,
        courses: [], faculty: [])),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Info>>.value(
      catchError: null,
      value: DatabaseService(uid: widget.uid).users,
      initialData: const [],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: indexing,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 23,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            currentIndex: indexing,
            onTap: (index) {
              setState(() {
                indexing = index;
              });
            },
            backgroundColor: Colors.white,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: "Messages",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],),
        ),
      ),
    );
  }
}


