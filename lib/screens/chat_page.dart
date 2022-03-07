import 'package:flutter/material.dart';
import 'package:tuts_app/models/user.dart';
import 'package:tuts_app/screens/profile_header_widget.dart';
import 'messages_widget.dart';
import 'new_message.dart';

class ChatPage extends StatefulWidget {
  final MainUser user;

  const ChatPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Colors.orange,
    body: SafeArea(
      child: Column(
        children: [
          ProfileHeaderWidget(name: widget.user.name),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: MessagesWidget(uid: widget.user.uid),
            ),
          ),
          NewMessageWidget(uid: widget.user.uid)
        ],
      ),
    ),
  );
}