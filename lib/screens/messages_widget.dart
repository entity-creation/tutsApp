import 'package:flutter/material.dart';
import 'package:tuts_app/shared/loading.dart';
import '../api/firebase_api.dart';
import '../models/message.dart';
import 'message_widget.dart';
import 'package:tuts_app/data.dart';
import 'package:provider/provider.dart';
import 'package:tuts_app/services/auth.dart';
import 'package:tuts_app/models/user.dart';

//The uid you were putting was empty, and this was where the issue was
class MessagesWidget extends StatelessWidget {
  final String uid;

  const MessagesWidget({
    required this.uid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String groupId = "";

    dynamic launcher = Provider.of<Tester?>(context);
    if (launcher.uid.hashCode <= uid.hashCode) {
      groupId = "${launcher.uid}-$uid";
    } else {
      groupId = "$uid-${launcher.uid}";
    }
    print("${launcher.uid}-$uid");
    return StreamBuilder<List<Message>>(
      stream:
          //The getmessage function should have a valid uid, not an empty string
          FirebaseApi.getMessages(groupId) as dynamic,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: Loading());
          default:
            if (snapshot.hasError) {
              return buildText('Something Went Wrong Try later');
            } else {
              final messages = snapshot.data;

              return messages!.isEmpty
                  ? buildText('Say Hi..')
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];

                        return MessageWidget(
                          message: message,
                          isMe: message.uid == launcher.uid,
                        );
                      },
                    );
            }
        }
      },
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
