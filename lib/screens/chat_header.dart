import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuts_app/models/user.dart';

import 'chat_page.dart';

class ChatHeaderWidget extends StatelessWidget {
  final List<MainUser> users;

  const ChatHeaderWidget({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic launcher = Provider.of<Tester>(context);
    return Container(
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
                  print(" User ${users[index]}");
                  if (users[index].uid != launcher.uid) {
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
                            backgroundImage: user.urlAvatar != "image"
                                ? NetworkImage(user.urlAvatar)
                                : AssetImage("images/default_profile.jpg")
                                    as ImageProvider),
                      ),
                    );
                  }
                  return Container();
                }),
          )
        ],
      ),
    );
  }
}
