import 'package:flutter/material.dart';
import 'package:tuts_app/models/user.dart';

import 'chat_page.dart';

class ChatHeaderWidget extends StatelessWidget {
  final List<MainUser> users;

  const ChatHeaderWidget({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.75,
          child: Text(
            'Chats',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              if (index == 0) {
                return Container(
                  margin: EdgeInsets.only(right: 12),
                  child: CircleAvatar(
                    radius: 24,
                    child: Icon(Icons.search),
                  ),
                );
              } else {
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatPage(user: users[index]),
                      ));
                    },
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(user.urlAvatar),
                    ),
                  ),
                );
              }
            },
          ),
        )
      ],
    ),
  );
}