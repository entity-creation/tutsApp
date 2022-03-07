import 'package:flutter/material.dart';
import 'package:tuts_app/api/firebase_api.dart';
import 'package:tuts_app/models/user.dart';
import 'package:tuts_app/shared/loading.dart';
import '../screens/chat_header.dart';
import '../screens/chat_body.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key, MainUser? users, MainUser? user}) : super(key: key);

  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24, color: Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<MainUser>> (
            stream: FirebaseApi.getUsers(),
            builder: (context, snapshot) {

              switch (snapshot.connectionState) {

                case ConnectionState.waiting:
                  return Center(child: Loading());
                default:

                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return buildText('Something Went Wrong Try Again later');
                  } else {
                    final users = snapshot.data;

                    if (users!.isEmpty) {
                      return buildText('No Users Found');
                    } else {
                      return Column(
                        children: [
                          ChatHeaderWidget(users: users),
                          ChatBodyWidget(users: users),
                        ],
                      );
                    }

                  }
              }
            }),
      ),
    );
  }
}

