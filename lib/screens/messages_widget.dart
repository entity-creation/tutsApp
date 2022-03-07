import 'package:flutter/material.dart';
import 'package:tuts_app/shared/loading.dart';
import '../api/firebase_api.dart';
import '../models/message.dart';
import 'message_widget.dart';
import 'package:tuts_app/data.dart';

class MessagesWidget extends StatelessWidget {
  final String uid;

  const MessagesWidget({
    required this.uid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
    stream: FirebaseApi.getMessages(uid) as dynamic,
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
                  isMe: message.uid == myId,
                );
              },
            );
          }
      }
    },
  );

  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24),
    ),
  );
}