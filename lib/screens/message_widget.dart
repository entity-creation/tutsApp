import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuts_app/api/firebase_api.dart';
import 'package:tuts_app/models/user.dart';
import 'package:tuts_app/pages/profile_page.dart';
import 'package:tuts_app/services/database.dart';
import 'package:tuts_app/shared/sharedPref.dart';
import '../models/message.dart';

class MessageWidget extends StatefulWidget {
  final Message message;
  final bool isMe;

  const MessageWidget({required this.message, required this.isMe, Key? key})
      : super(key: key);

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  SharedPreferences? preferences;
  String url = "";

  @override
  void initState() {
    super.initState();
    instantiatePref().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> instantiatePref() async {
    preferences = await SharedPreferences.getInstance();
    url = await preferences!.getString("profileUrl") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);
    dynamic launcher = Provider.of<Tester?>(context);

    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (widget.isMe)
          CircleAvatar(radius: 16, backgroundImage: NetworkImage(url)),
        widget.message.uid == launcher.uid
            ? Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                constraints: BoxConstraints(maxWidth: 140),
                decoration: BoxDecoration(
                  color: widget.isMe
                      ? Colors.grey[100]
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: widget.isMe
                      ? borderRadius
                          .subtract(BorderRadius.only(bottomRight: radius))
                      : borderRadius
                          .subtract(BorderRadius.only(bottomLeft: radius)),
                ),
                child: buildMessage(),
              )
            : widget.message.recUid == launcher.uid
                ? Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(16),
                    constraints: BoxConstraints(maxWidth: 140),
                    decoration: BoxDecoration(
                      color: widget.isMe
                          ? Colors.grey[100]
                          : Theme.of(context).colorScheme.secondary,
                      borderRadius: widget.isMe
                          ? borderRadius
                              .subtract(BorderRadius.only(bottomRight: radius))
                          : borderRadius
                              .subtract(BorderRadius.only(bottomLeft: radius)),
                    ),
                    child: buildMessage(),
                  )
                : Container(
                    child: Center(
                      child: Text(
                        "Say Hi",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:
            widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.message.message,
            style: TextStyle(color: widget.isMe ? Colors.black : Colors.white),
            textAlign: widget.isMe ? TextAlign.end : TextAlign.start,
          ),
        ],
      );
}
